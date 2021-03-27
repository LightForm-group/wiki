---
title: Installation
author: Sakina Rehman
tags:
  - python
  - thermocalc
toc: true
subcollection: ThermoCalc Python
published: true
---

# ThermoCalc Python (TC-Python)

TC-Python is a Python™ language-based SDK available with Thermo-Calc which allows for easy and flexible coupling of Thermo-Calc calculations with other software programs. It was built in the popular language Python™ to give Thermo-Calc users access to many other programs, such as numerical packages like NumPy and SciPy, which can now be used in combination with our calculations. It can also be used from within Jupyter notebooks or comparable interactive Python™ consoles.

TC-Python can also be used to develop custom Property Models for the Property Model Calculator. User developed Property Models allow you to customize Thermo-Calc to meet your modelling needs. [1]

TC-Python was designed to be easy to learn and easy to use. For example, it:

- Uses intelligent code completion to help users more easily navigate through the available classes and methods.
- Allows users to easily do parallel computations.
- Takes an object-oriented approach, which makes it easier to reuse information (classes/methods) and more quickly run your calculations when you need to change the compositions.
- Guides users through the process of setting up the simulation, using good default values when you are unsure of what to use and prompting you to add missing information, for example. This minimizes the occurrence of errors and makes it an easy option even for those who do not have experience working with APIs.
- Includes several examples with the installation which can be used to both learn about the use of TC‑Python and as a way to build your own calculation simulation.

TC-Python includes all the powerful functionality available from within Thermo-Calc Graphical Mode and the majority of the features available in the classic Console Mode. It is the only Thermo-Calc SDK that couples with the Precipitation Module (TC-PRISMA). From TC-Python, users have access to all Thermo-Calc calculations, as well as Add-on Modules, including:

- Single equilibrium
- Phase (map) diagrams
- Property (step) diagrams
- Scheil Solidification Simulations
- Batch equilibrium - This is similar to single equilibrium calculations, but offers significant performance improvements when calculating a lot of fast single equilibria, which are systems with few or non-complicated phases
- Property Models - This includes both pre-installed libraries and custom property models built using TC-Python
- Precipitation simulations* - All of the precipitation calculations available in the Precipitation Module (TC-PRISMA) can be integrated into your own programming workflow with TC-Python. This is the first Thermo-Calc SDK that can be used for precipitation calculations.
- Diffusion simulations - All of the functionality available with the Diffusion Module (DICTRA) in Graphical Mode, and the majority of the commands available with Console Mode, are implemented for use in TC-Python

## Setting up your environment
For access to the module, please ask either Pratheek Shanthraj or Yichao Yao for access to a remote PC where the license for TC Python is available. Please provide a brief description as to why you would like to use the module as well as cc'ing any supervisors. Before you can run TC-Python, you must have your environment set up. This involves installing:

- Thermo-Calc Software
- Python
- NumPy
- Anaconda
- SciPy
- Jupyter

The remote PC should have the environment set up already with each of these packages installed. If for some reason these packages are missing please reinstall them. 

In order to use TC-Python, it would be useful to have a basic understanding of Python. This includes the understanding of functions, classes, lists, sets, tuples, dictionaries, for loops and modules. Many resources are available to help you get started with Python including the LightForm Wiki page, documentation, books, university courses, LightForm Python slack channel etc.

Finally, a suitable Integrated Development Environment (IDE) is required to use TC Python. The remote PC includes PyCharm and is a suitable IDE to use TC Python, you do not need to have ThermoCalc running.

## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Sakina Rehman at [sakina.rehman@postgrad.manchester.ac.uk](mailto:sakina.rehman@postgrad.manchester.ac.uk).

## References

[1] TC-Python: [https://thermocalc.com/products/software-development-kits/tc-python/](https://thermocalc.com/products/software-development-kits/tc-python/)  
