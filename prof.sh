#!/usr/bin/env bash
set -euo pipefail

cd pre-commit

echo install
venv/bin/pip uninstall -qy reorder-python-imports
venv/bin/pip install -q ..

echo profile
venv/bin/python -m prof reorder-python-imports --py37-plus $(git ls-files -- '*.py')
venv/bin/gprof2dot log.pstats | dot -Tsvg -o ../log.svg

echo best-of
best-of -n 20 -- venv/bin/reorder-python-imports --py37-plus $(git ls-files -- '*.py')
