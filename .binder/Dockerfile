# This file is what mybinder.org reads.
#
# It layers two small things on top of the pre-built image:
#   1. A `FROM` pointing at the GHCR image produced by
#      .github/workflows/build-binder-image.yml (from .binder/Dockerfile.source).
#   2. A `COPY` that injects the EMSC-2022 repo contents (Notebooks/, Lectures/,
#      etc.) into /home/jovyan/EMSC-2022/ so JupyterLab's file tree shows them.
#
# The repo root's `.dockerignore` keeps this COPY fast by excluding .git/,
# .pixi/, Jupyterbook/_build/, WebSlides/movies/, etc. — saves ~1.5 GB.
#
# To modify the runtime env: edit .binder/Dockerfile.source (CI rebuilds the
# GHCR image). To change what notebooks / content ship: edit the repo tree —
# Binder will rebuild this tiny launcher Dockerfile on the next launch.

FROM ghcr.io/anu-rses-education/binder-launcher:latest

# Nothing else. The image is intentionally generic — no course content
# baked in. Notebooks are pulled in at launch by `nbgitpuller` via a
# git-pull URL (see the README's launch badge), so the same image can
# serve multiple courses and notebook edits require no image rebuild.
