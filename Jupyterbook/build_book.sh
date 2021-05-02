#! /usr/bin/env bash

# This will build the slides, then the book

cd Lectures
source build_slides.sh 
cd ..

jupyter-book build . 
