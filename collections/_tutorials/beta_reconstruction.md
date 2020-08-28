---
title: Tutorial for beta reconstruction
author: Christopher Daniel
---

# Tutorial for beta reconstruction

## Running reconstruction.exe

The reconstruction.exe can be downloaded [here](https://github.com/LightForm-group/beta-reconstruction-archive/releases/tag/v1.1), this includes bug fixes of the source code to improve the file read speed and the size of maps that can be reconstructed.

*Notes on cleaning data using Aztec Channel 5 or Aztec Crystal* - Before running the beta reconstruction using the exectable (reconstruction.exe), the EBSD data will need to be cleaned. During cleaning, the indexed beta phase will need to be deleted, the alpha grains will need to be grown out so there are no non-indexed points, and the file will need to be exported in .ctf format. The step-by-step process is described in the `Tutorial for cleaning EBSD data`.

Open the reconstruction.exe on any windows computer.

Click File, Import CTF to import the data. This will take a few mins to load the data. Once loaded the screen will appear blank.

Click File, New Map, Beta Reconstruction. This will load an image of the map.

You can change the Min. Disor (minimum disorientation) and the Recon Dev. (reconstruction deviation) values in the cells, but the default 2 and 3 degress are usually fine for reconstruction in Ti alloys. These values will alter the maximum misorientation between orientations to be considered the same alpha variant and the maximum misorientation from the Burgers relationship for the reconstruction to be accepted.

Make sure you tick the Hide Progress (faster) cell, otherwise the reconstruction will take much longer to complete. Then click Reconstruct.

When the reconstruction is complete a new beta map will appear. Click Save Beta CTF to save it.

The reconstructed .ctf file can then be loaded in Channel 5 by first importing the data - Project, Import, Channel Text File (\*.ctf).

## Possible errors with reconstruction.exe and how to solve them

## Beta reconstruction in Python

A python package to run the beta reconstruction is also available [here](https://github.com/LightForm-group/beta-reconstruction), which currently uses the existing functions of [DefDap](https://github.com/MechMicroMan/DefDAP). This python package will have a number of advantages compared with the executable - it is a lot faster, the statistics for the grain reconstruction can checked, and the results can be weighted by particular factors such as any indexed beta orientations recorded at room temperature.

## Beta reconstruction in MTEX

A beta reconstruction feature is also available in the latest version of MTEX, as explained in the documentation - [Parent Beta Phase Reconstruction in Titanium Alloys](https://mtex-toolbox.github.io/TiBetaReconstruction.html).
