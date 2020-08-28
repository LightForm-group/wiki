---
title: Tutorial for beta reconstruction
author: Christopher Daniel
---

# Tutorial for beta reconstruction

## Running reconstruction.exe

The reconstruction.exe can be downloaded [here](https://github.com/LightForm-group/beta-reconstruction-archive/releases/tag/v1.1), this includes bug fixes of the source code to improve the file read speed and the size of maps that can be reconstructed.

*Notes on cleaning data using Aztec Channel 5 or Aztec Crystal* - Before running the beta reconstruction using the exectable (reconstruction.exe), the EBSD data will need to be cleaned. During cleaning, the indexed beta phase will need to be deleted, the alpha grains will need to be grown out so there are no non-indexed points, and the file will need to be exported in .ctf format. The step-by-step process is described in the `Tutorial for cleaning EBSD data`.

Open the reconstruction.exe on any windows computer.

[TODO]

## Possible errors with reconstruction.exe and how to solve them

## Beta reconstruction in Python

A python package to run the beta reconstruction is also available [here](https://github.com/LightForm-group/beta-reconstruction), which currently uses the existing functions of [DefDap](https://github.com/MechMicroMan/DefDAP). This python package will have a number of advantages compared with the executable - it is a lot faster, the statistics for the grain reconstruction can checked, and the results can be weighted by particular factors such as any indexed beta orientations recorded at room temperature.

## Beta reconstruction in MTEX

A beta reconstruction feature is also available in the latest version of MTEX, as explained in the documentation - [Parent Beta Phase Reconstruction in Titanium Alloys](https://mtex-toolbox.github.io/TiBetaReconstruction.html).
