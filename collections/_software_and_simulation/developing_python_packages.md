---
title: Developing and publishing Python packages
author: Adam Plowman
toc: true
tags:
  - python
published: true
subcollection: Python
---

This is a short guide on how to develop and publish Python packages. This is just my workflow; you may wish to modify to suit your needs!

## Directory structure

When developing a Python package, we should use version control (e.g. `git`) to keep track of changes we make. In the following, I assume you are familiar with the basics of using `git`. The directory structure that I tend to use on my computer when developing a Python package looks something like this:

```
git-repo-name/
  mypackage/
    __init__.py
    mymodule.py
  tests/
    test_mymodule.py
  setup.py
  environment.yml
  CHANGELOG.md
```

Here is a run down of the above directory structure:

- `git-repo-name` is the top-level folder that contains everything related to the package. Everything within this folder is under version control, using `git`.
- The code of the actual Python package is contained in a sub-directory, named above as `mypackage`. This is the name that will be used by our users when they want to install our package; they will type: `pip install mypackage`. Within the `mypackage` directory, we have two Python files:

  - `__init__.py` is used to signify to Python that the `mypackage` is a *package*. It is not strictly necessary these days, but it is useful for other reasons, so I always keep it in.
  - `mymodule.py` is a Python file that contains the code of your package. This is where you put the code that does useful stuff. In fact, we are not limited to just a single Python file (or *module*, as it is more technically known). We can write many modules and put them all within the `mypackage` directory. We can even use sub-folders to make sub-packages (each with their own `__init__.py` file).

- `setup.py` is an installation script that is used to install our package.
- `environment.yml` is a conda environment file that allows us isolate a bit of our computer just for the development of this package. This is very useful, since it avoids conflicting dependencies. For instance, our new package might require a specific version of some other published package, but we may have already installed a different version of that package for some other reason.
- The `CHANGELOG.md` file is a markdown file that contains a list of changes that we've made before each release. This acts as a very useful summary of any important changes.
- Finally, the `tests` folder contains unit tests for each module.

## Virtual environments

As mentioned, when developing a Python package, it is preferable to isolate a bit of your computer for the sole purpose of developing that particular package. The main reason we do this is to maximise the chance that our users can successfully install our package on their own systems! There are different ways to set up these so-called *virtual environments*. My preferred way is to use conda environments. To do this, we need to specify an `environment.yml` file within our repository, as above. The `environment.yml` file contains a specification of the required Python version and can also list other packages that should be installed as dependencies.

In fact, the `environment.yml` file should really be seen as a way to specify the *development* environment, and not the actual dependencies that our package code needs to work (this is covered later). For example, our `environment.yml` file may look like this:

```yml
name: mypackage_env
dependencies:
- python>=3.6
- pip          # Allows us to install packages from PyPI
- pylint       # Useful packages for developing
- rope         # Useful packages for developing
- autopep8     # Useful packages for developing
- twine        # Required to allow uploading to PyPI
- ipykernel    # Allows us to use this environment within a Jupyter notebook.

```

In the above, we first specify a name for the environment; I usually just name it as the package name, appended with "env". Additionally, we specify the allowed Python versions (here, greater than or equal to Python 3.6), along with a bunch of other Python packages. `pylint`, `rope` and `autopep8` are packages that I use when I'm developing a package, but are not necessary for our end users (they help with things like code formatting and checking for syntax errors). Likewise, the `twine` package is used to help us upload our package to the Python package index (PyPI), which is what enables other users to install our package. The `ipykernel` package will allow us to use the environment within a Jupyter notebook.

To create the environment, navigate to the same directory as the `environment.yml` file and type:

```
conda env create
```

This will install the Python version and packages listed in the `environment.yml` file as a new conda environment. Our new conda environment should show up with any other installed conda environments when we type `conda env list`. To use our new conda environment, we need to activate it[^1]:

```
conda activate mypackage_env
```

At this point, the only Python packages that we'll be able to use are those listed in the `environment.yml` file. (We can stop using the environment by deactivating it: `conda deactivate`.)

## Installing our package in "editable" mode

We now have a virtual environment in which to begin our development work. Next, we need to install our package within this environment, so we can start testing and using it. We'll use `pip` to install our package. You may be familiar with using `pip` to install packages that other people have published (indeed, we will make sure our package is available to our users via `pip`). However, we can also use `pip` to install local Python packages, which is what we need to do here. The `pip install` command essentially runs through the code in our `setup.py` script. An example `setup.py` file looks like this:

```python
from setuptools import find_packages, setup

setup(
    name='mypackage',
    version='0.1.0,
    description='This package does some very useful things.',
    author='Adam J. Plowman',
    packages=find_packages(),
    install_requires=[
        'numpy',
    ],
    project_urls={
        'Github': 'https://github.com/aplowman/mypackage',
    },
    classifiers=[
        'Development Status :: 4 - Beta',
    ],
)
```

The `setup` command has as its arguments a bunch of metadata about our package, like who wrote it and where it can be found on GitHub. Also included is the `install_requires` parameter, which is where we list other packages that are required by our package and that should therefore be installed as part of the installation process. In the above example, we are indicating that our package needs `numpy` to work. Note that packages that our code needs to work are listed here in the `setup.py` file, whereas packages that we use to help us develop our package (and so are not required by our end users) are listed in the `environment.yml` file.

The best way to install a package that we are actively developing is to install it in "editable" (or "development") mode. This means that any changes we make to the code are immediately applied when we use the package. If we didn't do this, each time we made a change to the code, we would have to reinstall the package. With our new environment activated (see above), and assuming we are within the same directory as the `environment.yml` file, we can install our package in editable mode like this:

```
pip install -e .
```

The `-e` argument ensures that the package is installed in editable mode.

## Using our environment within a Jupyter notebook

To enable our environment to show up as a separate kernel within Jupyter, we need to tell Jupyter about it. Assuming our environment is active (see above), and that we have `ipykernel` installed (which will be the case if `ipykernel` is listed in the `environment.yml` file, as above), then we simply type:

```
python -m ipykernel install --user --name=mypackage_env
```

Note that we need to give the new Jupyter kernel a name. I usually just use the same name as the environment (i.e. the package name appended with "env"). `mypackage_env` should now show up as an available kernel within Jupyter notebook. I find this useful during development work.

## Publishing our package to PyPI

After we have developed our package (to the extent where it can, in principle, be useful to others---it needn't be perfect!), we can *publish* it to the Python package index (PyPI). Once this is done, other people can install it by simply typing `pip install mypackage`.

The first thing you'll need to do is register new accounts on [https://test.pypi.org/](https://test.pypi.org/) and on [https://pypi.org/](https://pypi.org/). (You can skip the "test" site if you want, but it allows us to check that our package will be uploaded correctly before we do it for real.) The credentials you register will be used when we use `twine` to upload our package, as below.

The steps I take to publish a new release of a package are as follows. These steps include publishing to PyPI, and also adding a new release on GitHub. Assuming our environment is active (see above):

- Commit any changes to `git`.
- Update `CHANGELOG.md` to include a summary of the changes (fixes, additional functionality, other changes) that you've made since the last release.
- Update the package version number (e.g. in the `setup.py` file)
- Commit these changes to `git` with a message like: `git commit "Prep for vx.y.z"` (i.e. this commit is preparation for a new release version)
- Add a git tag for this release with the tag being the version number: `git tag vx.y.z. -m "Add vx.y.z tag for PyPI"`
- Push the new tag to GitHub: `git push --tags origin master`
- Add a "release" on GitHub using the newly added tag.
- Generate distribution archives in the repository directory:
  ```
  python setup.py sdist bdist_wheel
  ```
- Upload the distribution archives to the PyPI *test* site (you will be prompted for your credentials): 
  ```
  twine upload --repository-url https://test.pypi.org/legacy/ dist/*
  ```
- Visit https://test.pypi.org/legacy/mypackage to see if your package was successfully uploaded. If all is well, upload the distribution to the *real* PyPI site (you will be prompted for your credentials):
  ```
  twine upload dist/*
  ```

<hr/>

## Footnotes

[^1]: `conda activate` works the same on MacOS, Linux and Windows, but only with conda version 4.6 and later. See [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#managing-environments). Previous versions have platform-specific commands.
