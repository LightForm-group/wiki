---
title: Introduction to MTEX
author: Peter Crowther
tags:
  - MTEX
  - MATLAB
  - EBSD
published: true
---

# Introduction to MTEX

This guide is designed to be a basic introduction to the MTEX toolbox - a series of MATLAB scripts which can be uses for the analysis of EBSD data.

## Installing MTEX

* First install MATLAB. MATLAB may be installed on University owned computers and downloaded from: http://www.software.itservices.manchester.ac.uk/ . The MATLAB licence does *not* allow installation on personally owned computers.
* Download the latest version of MTEX from: http://mtex-toolbox.github.io/download.html
* Unzip the folder to somewhere on your computer. A good place might be your Docuements folder.
* In MATLAB, navigate to the mtex folder you just unzipped and run the command `startup_mtex`. If you get some links to import data then MTEX is correctly installed.

## EBSD Data files

If you are using an Oxford EBSD instrument it is a good idea to use .crc files to store EBSD data where possible as these are easy to import and store metadata assocaited with the exeperiment. The .CPR file stores metadata assoicated with the measurement and the .CRC file has the raw data.
** Insert info about other files here **

## Importing data

* Load MTEX using the `startup_mtex` command from the root of the MTEX folder.
* Press the `Import EBSD Data` button, this opens the import wizard. The import wizard does not actually import the data, it just makes a script for us to do the importing.
* In the import wizard, press the plus button to add a new file. MTEX understands a range of EBSD data formats. If you are importing a .cpr file then you can press finish and the required metadata will be automatically read.
* This will create an import script. Save this file along with your data.
* Run the whole script. If successful your data is now imported as an object called `ebsd` which you can see in the MATLAB workspace.

