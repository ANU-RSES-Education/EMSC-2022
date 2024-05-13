#!/usr/bin/env bash

## Take the pyodide .qmd files and translate them 
## for rendering on jupyter / binder.
## 
## ```{python} -> ```{python} .noeval
## ```{pyodide-python} -> ```{python}
##
## Copy these files to a .gitignored build location before
## quarto renders the documents
##
## Notes: 
##  - this is specific to the current pyodide plugin
##  - the .noeval seems to kill code highlighting in .qmd notebooks
##
##  


mkdir -p Basics4Binder
cp -r Basics/Images     Basics4Binder
cp -r Basics/Resources  Basics4Binder

cd Basics
for f in *qmd
do
  echo "Processing file: Basics/$f ..."
  cat ${f} | sed 's/{python}/{python}\ .noeval/g' | sed 's/{pyodide-python}/{python}/g' > ../Basics4Binder/${f}
  # cat "$f"
done

cd ..

## Anything else

