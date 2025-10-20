# Updating Your Course

This guide explains how to keep your course repository up-to-date with the latest extensions, packages, and template improvements.

## Quick Update (Recommended)

Run the interactive update script:

```bash
./update-template.sh
```

This script intelligently checks all components and only prompts for updates when needed:

1. **Quarto extensions** - Compares installed vs available versions
2. **Python packages** - Uses `pixi update --dry-run` to check for updates
3. **JupyterLite** - Detects if source files changed since last build
4. **Template improvements** - Fetches and shows recent template changes
5. **Test build** - Optional build verification

The script shows clear status for each component:
- ✓ Green checkmarks when everything is up to date
- ⚠ Yellow warnings when updates are available
- Only prompts for action when necessary

See the [Template Doctor documentation](https://anu-rses-education.github.io/EMSC-QuartoBook-Course/docs/template-doctor.html) for detailed information about the script.

## What Gets Updated

### 1. Quarto Extensions

**r-wasm/live** - Provides live-html format and pyodide support

Check current version:
```bash
cd WebBook
quarto list extensions
```

Update manually:
```bash
cd WebBook
quarto update extension r-wasm/live
```

### 2. Python Packages

Managed via `pixi.toml`. Key packages:
- quarto
- jupyterlite
- jupyterlite-pyodide-kernel
- ipython, ipykernel
- nbformat, nbclient

Update all:
```bash
pixi update
```

Update specific package:
```bash
pixi update quarto
```

### 3. JupyterLite

Rebuild after updating jupyterlite packages:

```bash
cd jupyterlite
pixi run jupyter lite build --contents content --output-dir dist
```

### 4. Template Improvements

The template itself receives updates. Two ways to stay current:

#### Automatic (Recommended)
- Template-sync GitHub Action runs monthly
- Creates pull requests with updates
- Review and merge when ready

#### Manual
Add template as remote and compare:

```bash
# First time only
git remote add template https://github.com/ANU-RSES-Education/EMSC-QuartoBook-Course.git

# Check for updates
git fetch template
git diff HEAD template/main

# See specific file changes
git diff HEAD template/main -- .github/workflows/publish.yml
```

## Update Frequency

**Recommended schedule:**

- **Quarto extensions**: Check at start of semester
- **Python packages**: Monthly or when issues arise
- **JupyterLite**: After package updates
- **Template**: Via automated PRs (monthly)

## Testing After Updates

Always test after updating:

```bash
# Build WebBook
pixi run quarto render WebBook

# Build WebSlides
pixi run quarto render WebSlides

# Check JupyterLite
cd jupyterlite && pixi run jupyter lite build --contents content --output-dir dist
```

## Troubleshooting Updates

### Extension Update Fails

```bash
# Remove and reinstall
cd WebBook
quarto remove extension r-wasm/live
quarto add r-wasm/live
```

### Package Conflicts

```bash
# Clean and reinstall
rm -rf .pixi
pixi install
```

### Build Breaks After Update

1. Check what changed:
   ```bash
   git diff pixi.lock
   ```

2. Revert to previous version:
   ```bash
   git checkout HEAD~1 pixi.lock
   pixi install
   ```

3. Report issue to template repository

## Version Tracking

Keep track of what you're running:

```bash
# Quarto version
quarto --version

# Python version
pixi run python --version

# List all packages
pixi list

# List extensions
cd WebBook && quarto list extensions
```

## See Also

- [Template Sync Documentation](https://anu-rses-education.github.io/EMSC-QuartoBook-Course/docs/template-sync.html)
- [Pixi Documentation](https://prefix.dev/docs/pixi/overview)
- [Quarto Extensions Guide](https://quarto.org/docs/extensions/)
