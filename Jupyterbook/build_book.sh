#! /usr/bin/env bash
set -euo pipefail

# This will build the slides, then the book

cd Lectures
source build_slides.sh
cd ..

jupyter-book build .

# Fail loudly if the book build silently produced nothing — otherwise the
# gh-pages deploy step will force-push an empty directory over the live site.
test -f _build/html/FrontPage.html

# This is best done by hand so it updates the slides even
# if there is no work to be done in rebuilding the book

cp -r Lectures/static_slides/slideshows _build/html

mkdir -p _build/html/Figures/Movies
cp -r Figures/Movies _build/html/Figures
