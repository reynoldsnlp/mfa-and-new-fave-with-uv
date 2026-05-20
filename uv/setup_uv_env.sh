#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PYTHON_VERSION=3.11

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

cd "$SCRIPT_DIR"

if [ ! -f "pyproject.toml" ]; then
  uv init --bare --no-readme --python "$PYTHON_VERSION"
fi

if grep -q '^requires-python = ' pyproject.toml; then
  sed -i.bak 's/^requires-python = .*/requires-python = ">=3.11,<3.12"/' pyproject.toml
  rm -f pyproject.toml.bak
fi

uv add --python "$PYTHON_VERSION" montreal-forced-aligner new-fave pgvector pynini
uv run --python "$PYTHON_VERSION" python toy_import_check.py
