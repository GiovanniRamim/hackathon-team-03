#!/usr/bin/env bash
#
# scripts/check.sh — Run all quality gates locally before pushing
#
# Mirrors the CI pipeline so teams can fail fast without waiting on GitHub Actions.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0

run_check() {
  local name="$1" cmd="$2" dir="${3:-.}"
  echo
  echo "== $name =="
  if [ ! -d "$dir" ]; then
    printf "${YELLOW}skip${NC} (no $dir)\n"
    return
  fi
  if (cd "$dir" && eval "$cmd"); then
    printf "${GREEN}PASS${NC} $name\n"
    PASS=$((PASS + 1))
  else
    printf "${RED}FAIL${NC} $name\n"
    FAIL=$((FAIL + 1))
  fi
}

# Backend
run_check "Backend tests"     "./mvnw -B verify"  "backend"

# Frontend
run_check "Frontend lint"      "pnpm lint"        "frontend"
run_check "Frontend typecheck" "pnpm typecheck"   "frontend"
run_check "Frontend tests"     "pnpm test --run"  "frontend"

# Infra
run_check "Terraform fmt"      "terraform fmt -check -recursive" "infra"

echo
echo "Summary: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
