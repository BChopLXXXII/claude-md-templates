#!/usr/bin/env bash
set -euo pipefail

# Verify common stack versions in templates/README against latest npm releases.
# Usage: ./scripts/check-versions.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FILES=("README.md" "templates/nextjs-app.md" "templates/react-vite.md" "templates/node-api.md" "templates/monorepo.md")

check_pkg() {
  local label="$1"
  local npm_pkg="$2"
  local needle="$3"

  local latest full short major
  full="$(npm show "$npm_pkg" version 2>/dev/null || true)"
  if [[ -z "$full" ]]; then
    echo "⚠️  Could not fetch version for $npm_pkg"
    return
  fi

  short="$(echo "$full" | awk -F. '{print $1"."$2}')"
  major="$(echo "$full" | awk -F. '{print $1}')"

  if grep -RIn "$needle $short\|$needle $major" "${FILES[@]}" >/dev/null; then
    echo "✅ $label is current in templates ($short.x, latest $full)"
  else
    echo "❌ $label mismatch: expected $short.x (latest $full)"
    grep -RIn "$needle" "${FILES[@]}" || true
  fi
}


echo "Checking template versions against npm..."
check_pkg "Next.js" "next" "Next.js"
check_pkg "React" "react" "React"
check_pkg "Vite" "vite" "Vite"
check_pkg "TypeScript" "typescript" "TypeScript"
check_pkg "Tailwind CSS" "tailwindcss" "Tailwind CSS"
check_pkg "React Router" "react-router" "React Router"

echo "Done."
