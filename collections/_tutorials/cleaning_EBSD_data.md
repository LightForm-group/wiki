---
title: Tutorial for cleaning EBSD data
author: Christopher Daniel
---

# Tutorial for cleaning EBSD data

## Why we need to clean EBSD data? [Chris]

- Producing nice figures
- Beta reconstruction
- Reproduction of features (twins, precipitate phases, misindexed orientations, etc.)

## Important examples of cleaned data [Alec]

## Different cleaning algorithms [Nick]

- Removing wild spikes
- Nearest neighbour
- Kuwahara

## Cleaning data using Aztec Channel 5 for beta reconstruction

Open up Aztec Channel 5 Project Manager - this manages the Tango (Map), Mambo (pole figure) and Salsa (ODF) packages. Load the Channel 5 `.cpr` project file, which allows Channel 5 to read the binary `.crc` data files, by clicking on the Project and then Open... tabs.

Click on statistics at the bottom of the window, select the Titanium Cubic phase, and click the Remove Phase from Project tab. This will remove all of the beta phase from the data. *Note, do not save this project as the original .cpr file as this will permanently delete any indexed beta phase.*

Drag the project to the Tango icon to open up the map. At this point it could be useful to plot an IPF map to view the orientations, by clicking on the Create new map icon.

Click on the Perform noise reduction icon to clean the map. Clicking on Wild spikes: Extrapolate will remove any single indexed points that are not surrounded by similar orientations. Depending on the resolution of the data, it may either be neccessary to remove all wild spikes, but it could also detrimentally affect the beta reconstruction. Our group tend to avoid removing wild spikes.

Use the standard nearest neighbour extrapolation to grow the alpha grains. Start with low level (8 nearest neighbour) extrapolation and make sure the iterate box is ticked. This will perform noise reduction and show the remaining fraction of non-indexed points. Allow a refinement to finish, then reduce the level to 7 nearest neightbours, then to 6, etc. until the remaining non-indexed points are exactly 0%. In cases where the map has a border, because the sample was smaller than the scan area, then you may need to reclick on extrapolate at 1 nearest neightbour to grow out the edges. Then click apply to apply this refinement to the data, this will change the map.

To save the data, click on Project, Export, as Channel Text File (\*.ctf).

*Note, if the data is too big to load into the beta reconstruction software or if there is a small region of the map you are interested in, you can use the subset selection tool, select a rectangle, and crop the area.*

## Cleaning data using Aztec Crystal for beta reconstruction [Alec]

## Cleaning data using MTEX [Nick]
