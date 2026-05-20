#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
VENV_DIR="$PROJECT_ROOT/.venv"

if ! command -v uv >/dev/null 2>&1; then
  python3 -m pip install --user uv
  export PATH="$HOME/.local/bin:$PATH"
fi

uv venv "$VENV_DIR"
uv pip install --python "$VENV_DIR/bin/python" montreal-forced-aligner new-fave pgvector
"$VENV_DIR/bin/python" "$PROJECT_ROOT/scripts/toy_import_check.py"
