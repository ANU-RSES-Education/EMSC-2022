#! /usr/bin/env bash

# This will build the slides, then the book

cd Lectures
source build_slides.sh 
cd ..

jupyter-book build . 


# This is best done by hand so it updates the slides even 
# if there is no work to be done in rebuilding the book 

cp -r Lectures/static_slides/slideshows _build/html

mkdir -p _build/html/Figures/Movies
cp -r Figures/Movies _build/html/Figures