#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

cd "$PROJECT_ROOT"

if [ ! -f "pyproject.toml" ]; then
  uv init --no-readme
fi

uv add montreal-forced-aligner new-fave pgvector
uv run python scripts/toy_import_check.py
