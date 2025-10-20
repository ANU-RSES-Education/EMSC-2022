# EMSC-QuartoBook-Course Template Inventory

## Purpose
This document inventories the template structure to:
1. Identify changes in derived repositories for back-propagation
2. Document template structure for automated syncing setup
3. Track which files are template infrastructure vs. course content

## Template Files (Infrastructure)

### Build & Deployment
- `build.sh` - Build script
- `.github/` - GitHub Actions workflows
- `pixi.toml` / `pixi.lock` - Python environment

### Configuration
- `_quarto/` - Quarto configuration
- `.jupyter/` - Jupyter configuration
- `.binder/` - Binder deployment setup
- `BinderREADME.md` - Binder documentation

### Content Structure Templates
- `WebBook/` - Book template structure
- `WebSlides/` - Slides template structure
- `jupyterlite/` - JupyterLite setup

### Project Files
- `.gitignore`
- `.gitattributes`
- `LICENSE`
- `README.md` (template instructions)

## Comparison Strategy

### Files to Compare Across Repositories
1. GitHub Actions workflows
2. Build scripts
3. Configuration files (pixi, quarto, jupyter)
4. Binder setup
5. Any helper scripts or utilities

### Files NOT to Compare (Content-Specific)
- Actual course content within WebBook/WebSlides
- Course-specific notebooks
- Custom styling/branding (unless improvement to template)

---

## Findings from Repository Comparisons

### EMSC-3022 Comparison

#### GitHub Actions Workflows

**publish.yml**
- EMSC-3022: Lines 7-8 have `branches:` on separate line with `- main` indented
- Template: Line 7 has `branches: main` on single line
- **Action**: Update template to match EMSC-3022 formatting (more conventional YAML style)

**jupyterlite.yml**
- EMSC-3022: Title is "Build and Deploy Jupyterlite"
- Template: Title is "Build and Deploy"
- **Action**: Update template title to be more descriptive

**template-sync.yml**
- Both are identical ✓
- Already properly configured to sync from ANU-RSES-Education/EMSC-QuartoBook-Course

#### Configuration Files

**pixi.toml**
- Template: Minimal dependencies (quarto, jupyterlite, jupyterlite-pyodide-kernel)
- EMSC-3022: Additional dependencies for course-specific work:
  - ipython, yaml, pyyaml, nbformat, nbclient, ipykernel
  - PyPI: pptx2md, wand
- **Action**: Consider adding common dependencies to template (ipython, ipykernel, nbformat, nbclient might be useful defaults)

**build.sh**
- Identical ✓

**.gitignore**
- Template has new CLAUDE symlink exclusion (just added)
- Otherwise identical ✓

#### Environment Files

**renderer.yml**
- Identical ✓

#### WebBook Configuration

**_quarto.yml** - Several important improvements found:

1. **Format configuration** (lines 43-53):
   - EMSC-3022 uses `live-html` format instead of `html`
   - Additional styling options: mainfont (Jost), fontsize (0.9em), linestretch (1.7)
   - Theme enhanced with assets/theme.scss
   - Commented pyodide filter showing intended integration
   - **Action**: Consider adding `live-html` format to template as an option

2. **Code links section** (lines 55-58):
   - EMSC-3022 has this section commented out (cleaner)
   - Template has it active with placeholder URL
   - **Action**: Comment out code-links in template by default

3. **Author field** (line 7-8):
   - EMSC-3022: Uses array format `- "Louis Moresi"`
   - Template: Uses single string `"Louis Moresi"`
   - **Action**: Update to array format for consistency (supports multiple authors)

4. **Bread-crumbs** (line 10):
   - EMSC-3022: `bread-crumbs: True`
   - Template: `bread-crumbs: false`
   - **Action**: Consider enabling by default (better navigation)

5. **Pyodide packages** (lines 65-73):
   - EMSC-3022 has more complete list including owslib
   - Template missing owslib
   - **Action**: Add owslib to template pyodide packages

6. **PDF output** (lines 75-76):
   - EMSC-3022: Commented out
   - Template: Active
   - **Action**: Consider commenting out by default (can be enabled per course)

#### Extensions
- Both have r-wasm extension ✓

### EMSC-3022 Summary

**High Priority Changes to Back-propagate:**
1. Fix YAML formatting in publish.yml (branches indentation)
2. Update jupyterlite.yml title to be more descriptive
3. Update WebBook/_quarto.yml:
   - Switch to live-html format
   - Add enhanced styling options (mainfont, fontsize, linestretch)
   - Use array format for author
   - Comment out code-links by default
   - Add owslib to pyodide packages

**Medium Priority:**
4. Consider adding common dependencies to pixi.toml (ipython, ipykernel, nbformat, nbclient)
5. Enable bread-crumbs by default
6. Comment out PDF format by default

---

### Zero-to-Python Comparison

#### GitHub Actions Workflows

**publish_quarto_book.yml** (vs template's publish.yml)
- Different filename but same content as template
- Uses single-line `branches: main` format (template also has this)
- **Note**: Filename differs from EMSC-3022 (which uses publish.yml)

**jupyterlite.yml**
- Same as template (title: "Build and Deploy")

**template-sync.yml**
- Has template sync configured

#### Configuration Files

**.gitignore** - Important additions:
```
## Generated folder
Basics4Binder
# pixi environments
.pixi
*.egg-info

## If you run jupyter-lite locally, it can mess up the github deployment if you leave these in place
#
**/.jupyterlite.doit.db
_output
**/.jupyter
```
- **Action**: Add jupyterlite-specific gitignore entries to template
- Prevents conflicts with local jupyterlite testing
- Useful comment explains the rationale

**pixi.toml**
- Identical to template ✓

#### WebBook Configuration

**_quarto.yml** - Consistent with EMSC-3022:
- Uses `live-html` format ✓
- Enhanced styling (mainfont, fontsize, linestretch) ✓
- Array format for author (multiple authors) ✓
- bread-crumbs: True ✓
- owslib in pyodide packages ✓
- PDF commented out ✓
- **Note**: Has code-links active (not commented like EMSC-3022)

#### Extensions
- r-wasm only ✓

### Zero-to-Python Summary

**Key Addition:**
- Enhanced .gitignore with jupyterlite-specific entries and helpful comments

**Confirmation:**
- Same _quarto.yml improvements as EMSC-3022
- Consistent use of live-html format and enhanced styling

---

## Consolidated Recommendations for Template

### 1. GitHub Actions (.github/workflows/)

**publish.yml:**
```yaml
# Line 7-8: Use conventional YAML formatting
branches:
  - main
```

**jupyterlite.yml:**
```yaml
# Line 1: Use descriptive title
name: Build and Deploy Jupyterlite
```

### 2. .gitignore

Add jupyterlite-specific entries:
```
# pixi environments
.pixi
*.egg-info

## If you run jupyter-lite locally, it can mess up the github deployment if you leave these in place
#
**/.jupyterlite.doit.db
_output
**/.jupyter
```

### 3. WebBook/_quarto.yml

**Critical changes:**
- Switch format from `html` to `live-html`
- Add enhanced styling:
  ```yaml
  live-html:
    theme: [united, "assets/theme.scss"]
    mainfont: "Jost"
    fontsize: 0.9em
    linestretch: 1.7
    linkcolor: "#C58812"
    number-sections: false
    number-depth: 1
  ```
- Change author to array format to support multiple authors
- Set `bread-crumbs: True`
- Add owslib to pyodide packages
- Comment out code-links section by default (users can enable if needed)
- Comment out PDF format by default

### 4. pixi.toml (Optional)

Consider adding common dependencies:
```toml
ipython = ">=9.4.0,<10"
ipykernel = ">=6.30.1,<7"
nbformat = ">=5.10.4,<6"
nbclient = ">=0.10.2,<0.11"
```

### 5. Plugin Management Strategy

Both repositories use r-wasm extension and jupyterlite. These should:
- Be included in template for testing
- Have clear update documentation
- Possibly have an update script (see todo #7)

---

## Implementation Summary

### All Changes Applied Successfully ✓

**Date:** 2025-10-15

**Files Modified:**
1. `.github/workflows/publish.yml` - Fixed YAML formatting (multi-line branches)
2. `.github/workflows/jupyterlite.yml` - Updated title to "Build and Deploy Jupyterlite"
3. `.gitignore` - Added jupyterlite-specific entries and pixi environment exclusions
4. `WebBook/_quarto.yml` - Multiple improvements:
   - Switched to `live-html` format
   - Added enhanced styling (Jost font, improved spacing, theme.scss)
   - Changed author to array format
   - Enabled bread-crumbs
   - Added owslib to pyodide packages
   - Commented out code-links and PDF format
   - Added `execute: enabled: false`
5. `pixi.toml` - Added common dependencies:
   - ipython, ipykernel, nbformat, nbclient
   - yaml, pyyaml (required for quarto jupyter integration)
6. `build.sh` - Made PDF copy conditional (won't fail if PDFs don't exist)

**Build Testing:**
- ✓ WebBook renders successfully with pixi environment
- ✓ WebSlides renders successfully with pixi environment
- ✓ All dependencies resolved correctly
- ✓ Output created in `_build/book/` and `_build/slides/`

**Notes:**
- Template now includes all improvements from EMSC-3022 and Zero-to-Python
- Ready for use as base template with automated sync
- Dependencies are complete for both basic and advanced usage

