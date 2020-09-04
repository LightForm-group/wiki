---
title: Installing pip packages within conda environments on the CSF
author: Adam Plowman
tags:
  - python
published: true
subcollection: Python
---

Installing Python packages via pip within a conda environment on the CSF:

1. Load Anaconda (e.g. `module load apps/anaconda3/5.2.0/bin`)
2. Activate the conda environment: `source activate /path/to/conda/env`
3. Tell conda to exclude system-wide packages: `echo "include-system-site-packages=false" >> $CONDA_PREFIX/pyvenv.cfg`
4. Pass the "target" option to `pip install`, specifying that the package should be installed in the site packages directory of the conda environment:

    `pip install --target /path/to/conda/env/lib/python_version/site-packages package-to-install`
    
Note that we don't need the `--user` option in this case (unlike when installing packages into the "root" environment on the CSF via pip).


See:
 - [https://stackoverflow.com/questions/51525072/global-pip-referenced-within-a-conda-environment](https://stackoverflow.com/questions/51525072/global-pip-referenced-within-a-conda-environment)
 - [https://pip.pypa.io/en/stable/reference/pip_install/#cmdoption-t](https://pip.pypa.io/en/stable/reference/pip_install/#cmdoption-t)
