---
title: Python virtual environments
author: Gerard Capes
tags:
  - python
  - CSF
published: true
subcollection: Python
---

## What are virtual environments and why should I use them?

A virtual environment is a way to manage dependencies separately for different projects. This can help to avoid conflicts between python packages, and makes your code [easier to reproduce](using-a-requirementstxt-file) because others will known which packages (and maybe even which versions of them) are needed to run your code. The virtual environment is isolated from other virtual environments, so packages installed in one project's virtual environment won't interfere with those in a different project's virtual environment.

## How to create a virtual environment

The easiest way is to use `venv` to create the environment, and `pip` to install packages. These tools come with any python installation so it doesn't matter whether you installed python from https://www.python.org/, Anaconda, or your OS already came with python installed.

The method is very slightly different on Linux/macOS and Windows, so read the relevant section below and/or read the [official docs](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/).

*In your project directory*, you create the virtual environment like this for Linux/macOS:

```bash
python -m venv .venv
```

and like this on Windows:

```
py -m venv .venv
```

Your prompt might change to indicate that you've activated a virtual environment, but you can check with `which python` (Linux/macOS) or `where python` (Windows). This will return the path to the python installation you're currently using which should be in the venv you just created.

### Activating the virtual environment

In order to use your venv and to install packages into it, you first need to activate it. For Linux/macOS:

```bash
source .venv/bin/activate
```

and on Windows:

```
.venv\Scripts\activate
```

### Installation of packages

*Having first activated your virtual environment*, you install packages with `pip` e.g.

```bash
pip install numpy
pip install matflow-new
```

### Deactivating the venv

When you want to switch projects, you first need to deactivate (shut down) the activate virtual environment using

```bash
deactivate
```

### Reactivating an existing virtual environment

Each time you want to use the virtual environment (e.g. after restarting your computer, closing your terminal etc) you need to reactivate it using either

```bash
source .venv/bin/activate
```

or

```
.venv\Scripts\activate
```

### Using a `requirements.txt` file

It is a good practice to save a list of dependencies for your project in a `requirements.txt` file, so that the project dependencies can be installed from it like this:    

```bash
pip install -r requirements.txt
```

The requirements file is just a list of package (and versions) to install e.g.

```
matflow-new=="0.3.0a138"
numpy
pandas
```
This aids in reproducibility, and makes it easier for others to run your code (and thus easier for them to help you).

### Installing a local package for development

If you are developing a package, you can install it in "editable" mode, which means that any changes you make to the source code will be reflected in your `venv` as soon as you save them. Assuming you're already in the directory containing the package to edit, you would use:

```bash
pip install --editable .
```

Note that the above command ends will a dot, which refers to the current directory.

### Considerations for HPC (e.g. CSF)

When recreating the venv on an HPC cluster, you would first want to load a recent version of python, because the system version of python is likely to be a bit out of date. Typically you would load a recent version of python using a module file, then follow the notes from the top of this page. On CSF3 you might use a command similar to this:

```bash
module load apps/binapps/anaconda3/2024.10
```
