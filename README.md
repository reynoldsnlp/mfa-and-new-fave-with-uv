# MFA and new-fave template

Examples of using package managers to install Montreal Forced Aligner and new-fave together.

## Recommended: Pixi (conda-based)

[Pixi](https://pixi.sh) is the recommended approach because Montreal Forced Aligner and all its dependencies are pre-built in conda-forge, avoiding compilation issues.

### Quick Start

1. **Install Pixi** (if not already installed):
   ```bash
   curl -LsSf https://pixi.sh/install.sh | bash
   ```

2. **Download the pixi configuration files to your project's folder**:

   **Option A: Command line (Linux/macOS/Windows with curl)**:
   ```bash
   cd /path/to/my/project/
   curl -O https://raw.githubusercontent.com/reynoldsnlp/mfa-and-new-fave-with-uv/main/pixi/pixi.toml
   curl -O https://raw.githubusercontent.com/reynoldsnlp/mfa-and-new-fave-with-uv/main/pixi/pixi.lock
   ```

   **Option B: Browser download**
   - Right-click and save [pixi.toml](https://raw.githubusercontent.com/reynoldsnlp/mfa-and-new-fave-with-uv/main/pixi/pixi.toml)
   - Right-click and save [pixi.lock](https://raw.githubusercontent.com/reynoldsnlp/mfa-and-new-fave-with-uv/main/pixi/pixi.lock)
   - Place both files in your project folder

3. **In your project folder, install the environment**:
   ```bash
   pixi install
   ```

4. **Run your own script with pixi (This example assumes you wrote a script named `my_script.py`)**:
   ```bash
   pixi run python my_script.py
   ```

Always use `pixi run python my_script.py` instead of `python3 my_script.py` so your script runs in the locked environment from `pixi.toml` and `pixi.lock`.

### Using pixi in Your Project

After copying `pixi.toml` and `pixi.lock`, you can:

- **Install dependencies**: `pixi install`
- **Run your script**: `pixi run python my_script.py`
- **Interactive shell**: `pixi shell` (then exit to leave)

If you open a pixi shell, using `python my_script.py` is fine inside that shell. Outside that shell, prefer `pixi run python my_script.py`.

### Why Pixi?

- **Pre-built binaries**: Montreal Forced Aligner and Kaldi are compiled in conda-forge
- **Hybrid conda/PyPI**: Uses conda for compiled packages (like kalpy) and PyPI for pure-Python packages (like new-fave)
- **Lock file**: `pixi.lock` ensures reproducible environments across platforms
- **Cross-platform**: Single `pixi.toml` works on Linux, macOS, and Windows

## Alternative: uv (PyPI-first)

The `uv/` directory contains experimental scripts using [uv](https://astral.sh/uv) (a fast Python package manager). This approach is not recommended for this use case because:

- Montreal Forced Aligner's Kaldi dependencies cannot be built from source on all platforms
- uv prioritizes PyPI, which doesn't have pre-built wheels for kalpy-kaldi

## CI

GitHub Actions workflow `.github/workflows/test-pixi-and-uv.yml` tests the pixi setup on Ubuntu and Windows, and the uv setup on Ubuntu, macOS, and Windows.
