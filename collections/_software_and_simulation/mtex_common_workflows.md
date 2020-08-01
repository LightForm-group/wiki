---
title: Common workflows in MTEX
author: Adam Plowman, Sumeet Mishra, Christopher Daniel
subcollection: MTEX
---

MTEX is a Matlab tool for texture analysis. Here are some common workflows in MTEX.

## Rotating data

It is easy to get confused with the crystal and sample orientations in MTEX. When starting off using MTEX, it can be useful to first check the results with Aztec Channel 5 or Aztec Crystal, to check they agree.

There are different ways to define the rolling directions and apply rotations to the data, these are explained here.

The usual convention for a rolled sample is that X = RD, Y = TD, Z =  ND. And the typical convention for pole figures is to have RD (x axis) NORTH, and TD (y axis) EAST, which is done by setting ND (z axis) into the plane.

```matlab
% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','intoPlane');
```

An example of applying a rotation to the orientation and spatial data is shown here. In this case, when the EBSD data was collected in the SEM microscope, the sample was aligned with RD out-of-plane, TD horizontal and ND vertical. The sample acquisition surface has X (RD) horizontal, Y (TD) vertical and Z (ND) out-of plane, so we need to apply a phi_1 = 90, PHI = 90 and phi_2 = 0 rotation to realign the Euler angle reference frame for the orientation data. We apply the command `keepXY` to keep the map coordinates as they are and to only change the Euler angle reference frame. However, if our spatial data (the map) also needs to be rotated, we can do that too. We apply the command `keepEuler` to preserve the Euler angles. By changing these values we can be sure that the orientations shown in our pole figures match with the ODF, and that our map is orientated as we would like.

```matlab
rot = rotation('Euler', 90*degree, 90*degree, 0*degree);
ebsd = rotate(ebsd,rot,'keepXY'); % rotate the orientation data
ebsd = rotate(ebsd,90*degree,'keepEuler') % rotate the spatial data
```

## Generating representative textures

There are a number of ways to generate model textures.

```matlab
cs = crystalSymmetry('cubic');
ss = specimenSymmetry('orthorhombic');

cube = orientation('Euler',[0,0,0]*degree,cs,ss);
odf_cube = unimodalODF(cube,'halfwidth',5*degree);
ori = calcOrientations(odf_Cube,500);
plotPDF(odf_cube,[Miller(1,1,1,cs)],'antipodal','complete');
```
