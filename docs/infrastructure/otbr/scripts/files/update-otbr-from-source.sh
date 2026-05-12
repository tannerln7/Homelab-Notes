#!/usr/bin/env bash
set -Eeuo pipefail

REPO="/root/ot-br-posix"
INFRA_IF_NAME="${INFRA_IF_NAME:-eth0}"
LOG="/var/log/otbr-source-update.log"
BACKUP_DIR="/var/backups/otbr-source-update"
LOCK="/run/otbr-source-update.lock"
FORCE_REBUILD=0

for arg in "$@"; do
  case "$arg" in
    --force|--force-rebuild)
      FORCE_REBUILD=1
      ;;
    -h|--help)
      echo "Usage: $0 [--force]"
      echo
      echo "  --force    Rebuild/reinstall even if the repo is already up to date."
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg"
      echo "Use --help for usage."
      exit 2
      ;;
  esac
done

mkdir -p "$BACKUP_DIR"

# Log to file and also show output in the terminal when run manually.
exec > >(tee -a "$LOG") 2>&1

step() {
  echo
  echo "------------------------------------------------------------"
  echo "$1"
  echo "------------------------------------------------------------"
}

echo
echo "============================================================"
echo "OTBR source update started: $(date -Is)"
echo "Repo: $REPO"
echo "Infra interface: $INFRA_IF_NAME"
echo "Force rebuild: $FORCE_REBUILD"
echo "Log: $LOG"
echo "============================================================"

exec 9>"$LOCK"
if ! flock -n 9; then
  echo "Another OTBR update is already running. Exiting."
  exit 0
fi

if [[ ! -d "$REPO/.git" ]]; then
  echo "ERROR: Repo not found at $REPO"
  exit 1
fi

cd "$REPO"

step "Checking current repository state"
git status -sb || true

step "Fetching upstream"
git fetch --prune origin

LOCAL_COMMIT="$(git rev-parse HEAD)"
REMOTE_COMMIT="$(git rev-parse '@{u}' 2>/dev/null || true)"

if [[ -z "$REMOTE_COMMIT" ]]; then
  echo "ERROR: No upstream tracking branch configured."
  echo "From $REPO, run something like:"
  echo "  git branch --set-upstream-to=origin/main"
  exit 1
fi

echo "Local:  $LOCAL_COMMIT"
echo "Remote: $REMOTE_COMMIT"

if [[ "$LOCAL_COMMIT" == "$REMOTE_COMMIT" && "$FORCE_REBUILD" -eq 0 ]]; then
  echo
  echo "Already up to date. No rebuild needed."
  echo "To force a rebuild anyway, run:"
  echo "  $0 --force"
  exit 0
fi

STAMP="$(date +%Y%m%d-%H%M%S)"

step "Backing up OTBR config files"
for f in /etc/default/otbr-agent /etc/default/otbr-web; do
  if [[ -f "$f" ]]; then
    cp -a "$f" "$BACKUP_DIR/$(basename "$f").$STAMP"
    echo "Backed up $f -> $BACKUP_DIR/$(basename "$f").$STAMP"
  else
    echo "Not present, skipping: $f"
  fi
done

if [[ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]]; then
  step "Updating repo with fast-forward only"
  git pull --ff-only --recurse-submodules
else
  step "Repo already current; force rebuild requested"
fi

step "Updating git submodules"
git submodule update --init --recursive

step "Running OTBR bootstrap"
./script/bootstrap

step "Running OTBR setup/install"
echo "This is the long step. It may compile/build/install packages and can look quiet for stretches."
INFRA_IF_NAME="$INFRA_IF_NAME" ./script/setup

step "Reloading systemd"
systemctl daemon-reload

step "Restarting OTBR services"
systemctl restart otbr-agent || {
  echo "ERROR: failed to restart otbr-agent"
  systemctl status otbr-agent --no-pager || true
  exit 1
}

if systemctl list-unit-files | grep -q '^otbr-web.service'; then
  echo "Restarting otbr-web..."
  systemctl restart otbr-web || true
else
  echo "otbr-web service not found, skipping."
fi

step "Verifying otbr-agent"
systemctl --no-pager --full status otbr-agent || true

step "Testing ot-ctl state"
timeout 10 ot-ctl state || true

echo
echo "============================================================"
echo "OTBR source update finished: $(date -Is)"
echo "============================================================"