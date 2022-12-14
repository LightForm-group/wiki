---
title: General Information
author: Sakina Rehman
tags:
  - thermocalc
  - morton pc
  - python
toc: true
subcollection: TC Python
published: true
---

TC-Python is a Python™ language-based SDK available with Thermo-Calc which allows for easy and flexible coupling of Thermo-Calc calculations with other numerical packages like NumPy, SciPy, and TensorFlow. The majority of calculations found within the Thermo-Calc graphical interface and console mode are available in TC-Python. This includes:
- Single equilibrium
- Phase diagrams
- Property diagrams
- Scheil solidification simulations
- Batch equilibrium (significant performance improvements when calculating multiple fast single equilibria)
- Property models
- Precipitation simulations
- Diffusion simulations
- Steel and Nickel libraries (set of Property Models designed to help experts working in the steel and nickel industry)
- Process Metallurgy Module calculations

## Installation

> TC Python is readily available and up to date on the Morton PC. Please logon to Morton PC and open PyCharm. If you run into any issues please see the information below or contact support below.

Install an IDE (PyCharm is recommended) at https://www.jetbrains.com/pycharm/download. Once installed, open PyCharm to configure the bundled Python-interpretator. Go to **File -> Settings** and navigate in the tree to **Project: YourProjectName** and choose **Project Interpreter**. Click on the **Settings** symbol and select **Add**. Choose **System Interpreter** and add the bundled Thermo-Calc Python 3 interpreter. For the Morton PC operating system, this would be:
```
C:\Program Files\Thermo-Calc\2022a\python\python.exe
```
For MacOS:
```
/Applications/Thermo-Calc-2022a.app/Contents/Resources/python/bin/python3
```
For Linux OS:
```
/home/UserName/Thermo-Calc/2022a/python/bin/python3
```

You should now be ready to run a TC-Python script, it is recommended that you run some of the examples provided by Thermo-Calc. Go to **File -> Open** and please navigate to the path of the TC-Python installation. Click on the **Examples** folder and from any subfolder run the example. Below is an example (```pyex_P_01_Precipitation_Al-Sc_AL3SC.py```) from the Precipitation subfolder, which simulates the kinetics of precipitation of Al3Sc from an FCC_A1 solution phase and shows some results, with minimally required settings. Default values are used for unspecified settings.

![alt text](https://www.dropbox.com/s/kpeaug0738ppzs4/tc_example.png?dl=0)

## Architecture

TC-Python contains classes of these types:

**TCPython** – this is where you start with general settings.
**SystemBuilder and System** – where you choose database and elements etc.
**Calculation** – where you choose and configure the calculation.
**Result** – where you get the results from a calculation you have run.

Please refer to https://download.thermocalc.com/docs/tc-python/2022a/html/architecture.html#tcpython for further information

## Contact

For questions, comments, bug-reports or contributions please email Sakina Rehman at [sakina.rehman@postgrad.manchester.ac.uk](mailto:sakina.rehman@postgrad.manchester.ac.uk). The University of Manchester also holds a subscription to Thermo-Calc support so please feel free to email [support@thermocalc.com](support@thermocalc.com). Please ensure you include the following information in your email:

- Name:
- Organisation Name: University of Manchester
- Department:
- Country: 
- Phone Number: 
- Software version: 
- Databases: 
- OS: Windows (Morton PC)
- Version: Windows 7 Enterprise (Morton PC)
- Description of Problem:
