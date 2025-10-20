#! /usr/bin/env bash

quarto render WebSlides
quarto render WebBook

# Copy PDFs if they exist (optional for template)
if [ -d "WebBook/Figures/PDFs" ] && [ "$(ls -A WebBook/Figures/PDFs/*.pdf 2>/dev/null)" ]; then
  mkdir -p _build/book/Figures/PDFs
  cp -r WebBook/Figures/PDFs/*.pdf _build/book/Figures/PDFs
fi
