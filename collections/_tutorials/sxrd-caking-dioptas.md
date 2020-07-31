---
title: Tutorial for Dioptas and PyFAI to cake SXRD diffraction pattern images
author: Christopher Daniel
---

## Caking diffraction pattern images using Dioptas and pyFAI on the iCSF

### iCSF

You will first need to contact IT services to get setup with an iCSF account. The iCSF ([interactive Computational Shared Facility](http://ri.itservices.manchester.ac.uk/icsf/)) gives us access to the University's high performance computing environment. This allows us to store and analyse our large Synchrotron X-ray Diffraction (SXRD) datasets as a group.

### What is caking?

Before we can analyse the diffraction pattern rings for changes in phase fraction, micromechanical response and texture, we need to *cake* the data. *Caking* converts our 2-dimensional image into slices (of particular azimuthal angles) to produce a number of intensity profiles versus 2-theta angle (or pixel position). We can then investigate how the intensity peak profile of particular lattice plane peaks change in particular directions over time. We can also run a full *azimuthal integration*, which sums up the intensities around the whole image, to produce a single intensity profile versus 2-theta angle. This can then be used to calculate the phase fraction, for instance.

### Opening Dioptas on the iCSF

To run the *caking* and *azimuthal integration* we have setup the program [Dioptas](http://www.clemensprescher.com/programs/dioptas) on the iCSF. Dioptas is a python-based data analysis and processing program used for processing synchrotron data. The program was developed at the DESY beamline in Germany. It can do the same job as DAWN, but is slightly easier to use and once the calibration files are setup the caking and azimuthal integration can be automated using a python script and the PyFAI package.

Log onto the iCSF by opening the terminal and using the secure shell (ssh) protocol; 

ssh -X mbcx9cd4@incline256.itservices.manchester.ac.uk

You will then be prompted to enter your password.

![](/wiki/assets/images/posts/DAWN_screenshot1.png)

Load the Dioptas module using the following commands in the terminal; 

[TODO]

### Creating a .poni calibration file in Dioptas

**Start Values**

This will then open the Dioptas graphical user interface (GUI).

Then, click on *'Load File'* and select a calibration diffraction pattern.

Input the distance (e.g. 1200 mm) and leave the box ticked as we want to refine this value.

Input the wavelength (e.g. 0.1393 A) and leave the box unticked as we don't want to refine this value.

Leave polarization as is (0.990).

Set pixel width and height (e.g. 296 um x 296 um)

Select calibrant (e.g. CeO2)

**Peak Selection**

Untick automatic increase.

Select automatic peak search.

Choose number of rings (e.g. 10).

Then click on the map to select some of the rings.

**Refinement Options**

Make sure automatic refinement is ticked.

Therefore, no need to change any of the other values.

**Run Refinement**

Click 'Refine' to run the refinement.

**Save calibration as .poni file**

### Caking and Azimuthal Integration using PyFAI

[TODO]
