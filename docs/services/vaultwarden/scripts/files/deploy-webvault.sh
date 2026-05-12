#!/usr/bin/env bash
set -euo pipefail

BUILDS_DIR="/usr/local/src/vaultwarden-web-src/builds"
DEST_DIR="/opt/vaultwarden/web-vault"

# Pick the highest version tarball matching: bw_web_v2026.2.0+0.tar.gz
# (Version sort works well for vYYYY.M.P+N formats.)
pick_latest_tar() {
  local tar
  tar="$(ls -1 "${BUILDS_DIR}"/bw_web_v*.tar.gz 2>/dev/null \
    | sort -V \
    | tail -n 1 || true)"
  if [[ -z "${tar}" ]]; then
    echo "ERROR: No web-vault tarballs found in ${BUILDS_DIR} (expected bw_web_v*.tar.gz)" >&2
    exit 1
  fi
  echo "${tar}"
}

TAR_PATH="$(pick_latest_tar)"
STAMP="$(date +%F-%H%M%S)"
STAGE_DIR="${DEST_DIR}.new"
OLD_DIR="${DEST_DIR}.old.${STAMP}"

echo "Deploying web-vault from: ${TAR_PATH}"
echo "Staging to: ${STAGE_DIR}"

# Clean stage dir
rm -rf "${STAGE_DIR}"
mkdir -p "${STAGE_DIR}"

# Extract new build
tar -C "${STAGE_DIR}" -xzf "${TAR_PATH}"

# Extract new build
tar -C "${STAGE_DIR}" -xzf "${TAR_PATH}"

# Determine actual web root (where index.html lives)
WEB_ROOT="${STAGE_DIR}"
if [[ ! -f "${WEB_ROOT}/index.html" ]]; then
  # Common case: tar contains a top-level directory like web-vault/
  if [[ -f "${STAGE_DIR}/web-vault/index.html" ]]; then
    WEB_ROOT="${STAGE_DIR}/web-vault"
  else
    # Generic fallback: search 2 levels deep for index.html
    found="$(find "${STAGE_DIR}" -maxdepth 2 -type f -name index.html -print -quit || true)"
    if [[ -n "${found}" ]]; then
      WEB_ROOT="$(dirname "${found}")"
    else
      echo "ERROR: Extracted build missing index.html (unexpected tar layout?)" >&2
      echo "Top-level files:" >&2
      ls -la "${STAGE_DIR}" >&2 || true
      exit 1
    fi
  fi
fi

echo "Using web root: ${WEB_ROOT}"

# Ensure destination parent exists
mkdir -p "$(dirname "${DEST_DIR}")"

# Atomic-ish swap:
# Move existing DEST aside, then move WEB_ROOT into place.
# If WEB_ROOT != STAGE_DIR, move STAGE_DIR out of the way first.
if [[ -d "${DEST_DIR}" ]]; then
  mv "${DEST_DIR}" "${OLD_DIR}"
fi

# If WEB_ROOT is nested, move it to a temp name then replace
if [[ "${WEB_ROOT}" != "${STAGE_DIR}" ]]; then
  TMP_DIR="${DEST_DIR}.new.root"
  rm -rf "${TMP_DIR}"
  mv "${WEB_ROOT}" "${TMP_DIR}"
  rm -rf "${STAGE_DIR}"
  mv "${TMP_DIR}" "${DEST_DIR}"
else
  mv "${STAGE_DIR}" "${DEST_DIR}"
fi

# Permissions
chown -R root:root "${DEST_DIR}"
chmod -R 755 "${DEST_DIR}"

echo "Deployed to ${DEST_DIR}"
echo "Previous version (if existed) moved to ${OLD_DIR}"
echo "Done."