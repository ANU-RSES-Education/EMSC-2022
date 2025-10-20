#!/usr/bin/env bash

# Template Update Script
# Updates Quarto extensions, Python packages, and checks for template improvements

set -e  # Exit on error

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}EMSC Template Update Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Function to print status
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if pixi is available
if ! command -v pixi &> /dev/null; then
    print_error "Pixi not found. Using system Python/Quarto instead."
    PIXI_CMD=""
else
    print_status "Pixi found"
    PIXI_CMD="pixi run"
fi

# 1. Update Quarto extensions
echo ""
echo -e "${BLUE}1. Checking Quarto extensions...${NC}"
cd WebBook

# Capture extension list
EXTENSIONS=$($PIXI_CMD quarto list extensions 2>&1)

if echo "$EXTENSIONS" | grep -q "r-wasm/live"; then
    print_status "Found r-wasm/live extension (live-html/pyodide)"

    # Show current version
    CURRENT_VERSION=$(echo "$EXTENSIONS" | grep "r-wasm/live" | awk '{print $2}')
    echo "   Installed version: $CURRENT_VERSION"

    # Check latest version from GitHub
    if command -v curl &> /dev/null; then
        LATEST_VERSION=$(curl -s https://api.github.com/repos/r-wasm/quarto-live/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
        if [ -n "$LATEST_VERSION" ]; then
            echo "   Latest release:    $LATEST_VERSION"

            if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
                if [ "$CURRENT_VERSION" \> "$LATEST_VERSION" ]; then
                    echo "   (You have a newer version than the latest release)"
                else
                    print_warning "Update available!"
                    echo ""
                    echo "   To update:"
                    echo "   cd WebBook && quarto remove extension r-wasm/live"
                    echo "   cd WebBook && quarto add r-wasm/live"
                fi
            else
                echo "   ✓ Extension is up to date"
            fi
        fi
    fi
else
    print_warning "r-wasm/live extension not found"
    read -p "   Install r-wasm/live extension? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $PIXI_CMD quarto add r-wasm/live
        print_status "Extension installed"
    fi
fi

cd ..

# 2. Update Python packages (pixi)
echo ""
echo -e "${BLUE}2. Checking Python packages...${NC}"

if command -v pixi &> /dev/null; then
    echo "   Checking for updates..."
    UPDATE_CHECK=$(pixi update --dry-run 2>&1)

    if echo "$UPDATE_CHECK" | grep -q "up-to-date"; then
        print_status "All packages are up to date"
        echo ""
        echo "   Key packages:"
        pixi list | grep -E "quarto|jupyterlite|ipython|jupyter" | head -5
    else
        print_warning "Updates available!"
        echo "$UPDATE_CHECK"
        echo ""
        read -p "   Update Python packages? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            pixi update
            print_status "Python packages updated"
        fi
    fi
else
    print_warning "Pixi not available, skipping Python package updates"
fi

# 3. Check JupyterLite
echo ""
echo -e "${BLUE}3. Checking JupyterLite...${NC}"

if [ -d "jupyterlite" ]; then
    cd jupyterlite

    if [ -f "requirements.txt" ]; then
        print_status "Found JupyterLite configuration"

        # Check if rebuild is needed
        NEEDS_REBUILD=false
        if [ ! -d "dist" ]; then
            print_warning "dist/ directory not found"
            NEEDS_REBUILD=true
        elif [ -n "$(find content requirements.txt -newer dist 2>/dev/null)" ]; then
            print_warning "Source files modified since last build"
            NEEDS_REBUILD=true
        else
            print_status "JupyterLite build is up to date"
            echo "   Last built: $(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" dist 2>/dev/null || echo 'unknown')"
        fi

        if [ "$NEEDS_REBUILD" = true ]; then
            echo ""
            read -p "   Rebuild JupyterLite? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $PIXI_CMD jupyter lite build --contents content --output-dir dist
                touch dist  # Update timestamp to mark as current
                print_status "JupyterLite rebuilt"
            else
                echo ""
                echo "   Tip: To mark as current without rebuilding, run: touch jupyterlite/dist"
            fi
        fi
    fi

    cd ..
else
    print_warning "JupyterLite directory not found"
fi

# 4. Check for template updates
echo ""
echo -e "${BLUE}4. Checking for template updates...${NC}"

# Check if this IS the template repository
REPO_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")

if [[ "$REPO_URL" == *"EMSC-QuartoBook-Course"* ]] || [[ "$REPO_URL" == *"EMSC-QuartoBook-Course.git"* ]]; then
    print_status "Running on template repository itself"
    echo "   This is the template - no upstream to check"
    echo "   Extensions and packages are now up to date"
elif git remote | grep -q "template"; then
    print_status "Template remote found"
    echo "   Fetching latest template changes..."
    git fetch template

    # Try to find the last template sync commit
    # Template-sync PRs have format: "chore/template_sync_<hash>"
    LAST_SYNC=$(git log --all --oneline | grep "template_sync_[a-f0-9]" | head -1 | grep -oE 'template_sync_[a-f0-9]{7}' | sed 's/template_sync_//' || echo "")

    if [ -n "$LAST_SYNC" ]; then
        # Check if this commit exists in template/main
        if git cat-file -e template/main 2>/dev/null; then
            # Find this commit in template history
            SYNC_IN_TEMPLATE=$(git log template/main --oneline | grep "^${LAST_SYNC}" | head -1 || echo "")

            if [ -n "$SYNC_IN_TEMPLATE" ]; then
                # Count new commits since last sync
                NEW_COMMITS=$(git rev-list --count ${LAST_SYNC}..template/main 2>/dev/null || echo "0")

                if [ "$NEW_COMMITS" -gt 0 ]; then
                    print_warning "Template has $NEW_COMMITS new commit(s) since last sync"
                    echo ""
                    echo "   New template changes:"
                    git log --oneline --no-decorate ${LAST_SYNC}..template/main | head -5 | sed 's/^/   - /'
                    if [ "$NEW_COMMITS" -gt 5 ]; then
                        echo "   ... and $((NEW_COMMITS - 5)) more"
                    fi
                    echo ""
                    echo "   To see detailed changes:"
                    echo "   git log ${LAST_SYNC}..template/main"
                    echo "   git diff ${LAST_SYNC}..template/main"
                    echo ""
                    echo "   The template-sync workflow will create a PR with these changes"
                else
                    print_status "Template is up to date"
                    echo "   (Last synced at commit: ${LAST_SYNC:0:7})"
                fi
            else
                print_warning "Last sync commit not found in template history"
            fi
        fi
    else
        # No template sync found, fall back to simple comparison
        BEHIND=$(git rev-list --count HEAD..template/main 2>/dev/null || echo "0")

        if [ "$BEHIND" -gt 0 ]; then
            print_warning "Template has changes (no sync history detected)"
            echo ""
            echo "   To see template commits:"
            echo "   git log template/main | head -20"
            echo ""
            echo "   The template-sync workflow will create PRs automatically"
        else
            print_status "No new template commits detected"
        fi
    fi
else
    print_warning "Template remote not configured"
    echo ""
    read -p "   Add template remote now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git remote add template https://github.com/ANU-RSES-Education/EMSC-QuartoBook-Course.git
        print_status "Template remote added"
        echo "   Fetching latest template changes..."
        git fetch template

        BEHIND=$(git rev-list --count HEAD..template/main 2>/dev/null || echo "0")

        if [ "$BEHIND" -gt 0 ]; then
            print_warning "Template is $BEHIND commits ahead"
            echo ""
            echo "   Recent template changes:"
            git log --oneline --no-decorate HEAD..template/main | head -5 | sed 's/^/   - /'
            echo ""
            echo "   To see detailed changes:"
            echo "   git diff HEAD template/main"
            echo "   git log HEAD..template/main"
        else
            print_status "Template is up to date"
        fi
    else
        echo ""
        echo "   You can add it later with:"
        echo "   git remote add template https://github.com/ANU-RSES-Education/EMSC-QuartoBook-Course.git"
    fi
fi

# 5. Test build
echo ""
echo -e "${BLUE}5. Test build${NC}"
read -p "   Run test build? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "   Building WebBook..."
    $PIXI_CMD quarto render WebBook
    print_status "Build successful"
fi

# Summary
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Update check complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo "Next steps:"
echo "  - Review any warnings above"
echo "  - Check template-sync workflow for automated updates"
echo "  - Test your course content with updated components"
echo ""
