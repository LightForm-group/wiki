---
title: Installing development versions of Python packages (e.g. MatFlow extensions) on the CSF
author: Adam Plowman
toc: true
tags:
  - python
  - matflow
published: true
subcollection: MatFlow
---

1. On the CSF, uninstall any "published" version of the package you wish to install from GitHub. For example, if you want to install a development version of the `matflow-damask` extension, first do `pip uninstall matflow-damask`. (Not sure if this step is required.)
2. Find the GitHub repository of the package you would like to install
3. Click on the green `Code` button and then copy the given URL:

![](/wiki/assets/images/posts/github_clone.jpg)

4. On the CSF, go to your home directory: `cd ~`, and then type: `git clone [GITHUB_URL]` where you should replace `[GITHUB_URL]` with the URL copied from step 3.
5. On the CSF, change directory into the new git repository that was just downloaded from GitHub, e.g. `cd matflow-damask`, and then use checkout the desired branch like this: `git checkout [DEV_BRANCH]` where you should replace `[DEV_BRANCH]` with the name of the development branch you wish to install.
6. On the CSF, install the package in "editable" mode like this: `pip install --user -e .` (note the ending full-stop). Using editable mode means that you can subsequently `git pull` changes and the changes will be reflected in your installed package.
