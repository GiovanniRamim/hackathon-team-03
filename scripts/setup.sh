#!/usr/bin/env bash
#
# scripts/setup.sh — Bootstrap a hackathon team repository
#
# Usage:
#   ./scripts/setup.sh
#
# What it does:
#   1. Verifies prerequisites (Java 21, Node 20, Docker, gh CLI)
#   2. Clones reference materials (legacy SIFAP code + reference prototype)
#      into ./reference/ (read-only, gitignored)
#   3. Initializes empty .specs/ directory for Specky pipeline
#   4. Verifies devcontainer is reachable

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# ANSI colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()    { printf "${GREEN}✓${NC} %s\n" "$*"; }
warn()  { printf "${YELLOW}!${NC} %s\n" "$*"; }
fail()  { printf "${RED}✗${NC} %s\n" "$*" >&2; }

echo "== SIFAP 2.0 team repo bootstrap =="
echo

# 1. Prerequisites
echo "Checking prerequisites..."
need_tool() {
  if command -v "$1" >/dev/null 2>&1; then
    ok "$1 found"
  else
    fail "$1 NOT found — install before continuing"
    exit 1
  fi
}
need_tool java
need_tool node
need_tool docker
need_tool git

if command -v gh >/dev/null 2>&1; then
  ok "gh CLI found"
else
  warn "gh CLI not found — you'll need it for Issue/PR automation"
fi

JAVA_VERSION=$(java -version 2>&1 | head -1 | grep -oE '"[0-9]+' | tr -d '"' || echo "0")
if [ "$JAVA_VERSION" -ge 21 ]; then
  ok "Java $JAVA_VERSION (>= 21 required)"
else
  fail "Java version $JAVA_VERSION too old — Java 21 required"
  exit 1
fi

NODE_VERSION=$(node -v | grep -oE '[0-9]+' | head -1 || echo "0")
if [ "$NODE_VERSION" -ge 20 ]; then
  ok "Node $NODE_VERSION (>= 20 required)"
else
  fail "Node version $NODE_VERSION too old — Node 20 required"
  exit 1
fi

# 2. Reference materials
echo
echo "Cloning reference materials (read-only)..."
mkdir -p reference

clone_or_pull() {
  local url="$1" dest="$2"
  if [ -d "$dest/.git" ]; then
    warn "$dest exists — skipping clone"
  else
    git clone --depth 1 "$url" "$dest"
    ok "Cloned $url"
  fi
}

# Public read-only legacy code
LEGACY_REPO="${LEGACY_REPO:-https://github.com/paulasilvatech/sifap-legacy.git}"

if [ ! -d "reference/sifap-legacy" ]; then
  clone_or_pull "$LEGACY_REPO" "reference/sifap-legacy"
fi

# Create the legacy/ symlink. prototype/ and infra/ are provided by facilitators
# at the start of Stages 3 and 4 (you'll get a tarball or archive).
ln -sfn "reference/sifap-legacy" legacy 2>/dev/null || true
ok "Linked legacy/ -> reference/sifap-legacy"
[ -d "prototype" ] || warn "prototype/ not present yet — facilitators provide it at Stage 3"
[ -d "infra" ] || warn "infra/ not present yet — facilitators provide it at Stage 4"

# 3. Initialize .specs/ for Specky
echo
echo "Initializing Specky workspace..."
mkdir -p .specs
if [ ! -f .specs/.gitkeep ]; then
  touch .specs/.gitkeep
fi
ok ".specs/ ready"

# 4. Devcontainer hint
echo
if [ -f .devcontainer/devcontainer.json ]; then
  ok "Dev container ready — open VS Code and 'Reopen in Container'"
else
  warn ".devcontainer/devcontainer.json not found"
fi

echo
echo "Done. Next steps:"
echo "  1. Read TEAM-FLOW.md"
echo "  2. Read your persona card in personas/"
echo "  3. Open Stage 1 guide: 01-arqueologia/GUIDE.md"
