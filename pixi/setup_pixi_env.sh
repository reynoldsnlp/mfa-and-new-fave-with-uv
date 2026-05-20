#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if ! command -v pixi >/dev/null 2>&1; then
  curl -LsSf https://pixi.sh/install.sh | bash
  export PATH="$HOME/.pixi/bin:$PATH"
fi

cd "$SCRIPT_DIR"
pixi run python toy_import_check.py
