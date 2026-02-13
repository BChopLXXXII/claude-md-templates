#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES_DIR="$REPO_ROOT/templates"

usage() {
  cat <<EOF
Usage:
  $(basename "$0") --template <name> [--output <path>] [--force]
  $(basename "$0") --list

Examples:
  $(basename "$0") --list
  $(basename "$0") --template react-vite
  $(basename "$0") --template node-api --output ./CLAUDE.md
  $(basename "$0") --template minimal --force
EOF
}

list_templates() {
  find "$TEMPLATES_DIR" -maxdepth 1 -type f -name "*.md" -printf "%f\n" \
    | sed 's/\.md$//' \
    | sort
}

TEMPLATE=""
OUTPUT="CLAUDE.md"
FORCE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --template)
      TEMPLATE="${2:-}"
      shift 2
      ;;
    --output)
      OUTPUT="${2:-}"
      shift 2
      ;;
    --force)
      FORCE=true
      shift
      ;;
    --list)
      list_templates
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$TEMPLATE" ]]; then
  echo "Error: --template is required." >&2
  usage
  exit 1
fi

SOURCE="$TEMPLATES_DIR/$TEMPLATE.md"
if [[ ! -f "$SOURCE" ]]; then
  echo "Error: template '$TEMPLATE' not found." >&2
  echo "Available templates:" >&2
  list_templates >&2
  exit 1
fi

if [[ -e "$OUTPUT" && "$FORCE" != true ]]; then
  echo "Error: '$OUTPUT' already exists. Use --force to overwrite." >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT")"
cp "$SOURCE" "$OUTPUT"

echo "✅ Created $OUTPUT from template '$TEMPLATE'"
