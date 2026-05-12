#!/bin/bash
set -euo pipefail

log() { echo "[$(date -Is)] $*"; }

# ---------------------------
# Vaultwarden server settings
# ---------------------------
REPO="/usr/local/src/vaultwarden-src"
BIN_SRC="$REPO/target/release/vaultwarden"
BIN_DST="/opt/vaultwarden/bin/vaultwarden"
ROLLBACK_DIR="/root/vaultwarden-rollbacks"
KEEP_ROLLBACKS=8

# ---------------------------
# Web-vault settings
# ---------------------------
WEB_REPO="/usr/local/src/vaultwarden-web-src"
WEB_VERSION_JSON="/opt/vaultwarden/web-vault/version.json"
DEPLOY_WEB_SCRIPT="/usr/local/bin/deploy-webvault.sh"

# Helpers
ver_gt() {
  # return 0 (true) if $1 > $2 using version sort
  # expects comparable strings like:
  #   1.35.4
  #   v2026.2.0
  #   v2025.12.1+build.3
  [[ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | tail -n1)" == "$1" ]] && [[ "$1" != "$2" ]]
}

norm_ver() {
  # Strip a single leading 'v' (v2026.2.0 -> 2026.2.0)
  echo "${1#v}"
}

# ---------------------------
# 1) Decide server update need
# ---------------------------
cd "$REPO"
git fetch --tags --force

LATEST_SERVER_TAG="$(git tag -l '[0-9]*.[0-9]*.[0-9]*' --sort=v:refname | tail -n1)"
if [[ -z "$LATEST_SERVER_TAG" ]]; then
  log "ERROR: Could not determine latest Vaultwarden server tag"
  exit 1
fi

CURRENT_SERVER_VER="$($BIN_DST --version 2>/dev/null | awk '{print $2}' || true)"
log "Vaultwarden server current: ${CURRENT_SERVER_VER:-unknown}"
log "Vaultwarden server latest : $LATEST_SERVER_TAG"

DO_SERVER_UPDATE=false
if [[ -z "${CURRENT_SERVER_VER:-}" ]]; then
  DO_SERVER_UPDATE=true
elif ver_gt "$LATEST_SERVER_TAG" "$CURRENT_SERVER_VER"; then
  DO_SERVER_UPDATE=true
fi

# ---------------------------
# 2) Decide web-vault update need
# ---------------------------
cd "$WEB_REPO"
git fetch --tags --force

LATEST_WEB_TAG="$(
  git tag -l 'v*' -l '[0-9]*' \
  | grep -E '^(v)?[0-9]+\.[0-9]+\.[0-9]+([\-][0-9A-Za-z.-]+)?([+][0-9A-Za-z.-]+)?$' \
  | sort -V \
  | tail -n1
)"

if [[ -z "$LATEST_WEB_TAG" ]]; then
  log "ERROR: Could not determine latest web-vault tag"
  exit 1
fi

CURRENT_WEB_VER=""
if [[ -f "$WEB_VERSION_JSON" ]]; then
  CURRENT_WEB_VER="$(jq -r '.version // empty' "$WEB_VERSION_JSON" 2>/dev/null || true)"
fi

CURRENT_WEB_VER_NORM="$(norm_ver "${CURRENT_WEB_VER:-}")"
LATEST_WEB_TAG_NORM="$(norm_ver "${LATEST_WEB_TAG:-}")"

log "Web-vault current: ${CURRENT_WEB_VER:-unknown} (norm: ${CURRENT_WEB_VER_NORM:-unknown})"
log "Web-vault latest : ${LATEST_WEB_TAG} (norm: ${LATEST_WEB_TAG_NORM})"

DO_WEB_UPDATE=false
if [[ -z "${CURRENT_WEB_VER_NORM:-}" || "${CURRENT_WEB_VER_NORM}" == "null" ]]; then
  DO_WEB_UPDATE=true
elif ver_gt "${LATEST_WEB_TAG_NORM}" "${CURRENT_WEB_VER_NORM}"; then
  DO_WEB_UPDATE=true
fi

# If neither needs updating, exit cleanly
if [[ "$DO_SERVER_UPDATE" != "true" && "$DO_WEB_UPDATE" != "true" ]]; then
  log "Everything already up to date. No action taken."
  exit 0
fi

# ---------------------------
# 3) Update Vaultwarden server (if needed)
# ---------------------------
if [[ "$DO_SERVER_UPDATE" == "true" ]]; then
  cd "$REPO"

  log "Updating Vaultwarden server to $LATEST_SERVER_TAG"

  # Checkout tag (detached HEAD)
  git checkout -f "$LATEST_SERVER_TAG"

  # Verify signed tag (hard fail if not valid)
  log "Verifying server tag signature..."
  git tag -v "$LATEST_SERVER_TAG" >/dev/null

  # Build
  log "Building server release..."
  source "$HOME/.cargo/env" 2>/dev/null || true
  cargo build --features sqlite --release

  if [[ ! -x "$BIN_SRC" ]]; then
    log "ERROR: build did not produce expected binary at $BIN_SRC"
    exit 1
  fi

  # Pre-update backup (DB + attachments/sends)
  log "Running pre-update backup..."
  /usr/local/bin/vaultwarden-backup.sh

  # Rollback bundle
  mkdir -p "$ROLLBACK_DIR"
  RB="$ROLLBACK_DIR/vaultwarden-${CURRENT_SERVER_VER:-unknown}-to-${LATEST_SERVER_TAG}-$(date +%F-%H%M).tgz"
  log "Creating rollback bundle: $RB"
  tar -C / -czf "$RB" opt/vaultwarden

  # Install + restart
  log "Stopping service..."
  systemctl stop vaultwarden

  log "Installing new server binary..."
  install -m 0755 "$BIN_SRC" "$BIN_DST"

  log "Starting service..."
  systemctl start vaultwarden

  log "Healthcheck..."
  /usr/local/bin/vaultwarden-healthcheck.sh

  log "Server update successful: $($BIN_DST --version)"

  # Cleanup old rollback bundles
  ls -1t "$ROLLBACK_DIR"/vaultwarden-*.tgz 2>/dev/null | tail -n +$((KEEP_ROLLBACKS+1)) | xargs -r rm -f
else
  log "Vaultwarden server is up to date; skipping server build/update."
fi

# ---------------------------
# 4) Update web-vault (if needed)
# ---------------------------
if [[ "$DO_WEB_UPDATE" == "true" ]]; then
  cd "$WEB_REPO"

  log "Updating web-vault to $LATEST_WEB_TAG"

  # (Optional but nice) verify the tag exists locally now
  git rev-parse "$LATEST_WEB_TAG" >/dev/null

  # Build + deploy
  log "PATH=$PATH"
  log "which node: $(command -v node || echo none)"
  log "which npm : $(command -v npm  || echo none)"
  node -v || true
  npm  -v || true
  env | grep -E '^(HOME|NODE_OPTIONS|CI|MAKEFLAGS|NPM_CONFIG_CACHE|XDG_CACHE_HOME)=' || true

  make full
  "$DEPLOY_WEB_SCRIPT"

  log "Web-vault update deployed."
else
  log "Web-vault is up to date; skipping web-vault build/deploy."
fi

log "Done."