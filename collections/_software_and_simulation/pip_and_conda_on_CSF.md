---
title: Installing pip packages within conda environments on the CSF
author: Adam Plowman
tags:
  - python
published: true
---

Installing Python packages via pip within a conda environment on the CSF:

1. Activate the environment.
2. `echo "include-system-site-packages=false" >> $CONDA_PREFIX/pyvenv.cfg`
3. Pass the "target" option to `pip install`, specifying that the package should be installed in the site packages directory of the conda environment:

  `pip install --target /path/to/conda/env/lib/python_version/site-packages package-to-install`
