---
title: Common workflows in MTEX
author: Adam Plowman, Sumeet Mishra, Christopher Daniel, Nicholas Byres
subcollection: MTEX
---

MTEX is a Matlab tool for texture analysis. Here are some common workflows in MTEX.

## Crystal orientations and spatial data

Each EBSD data point has various data associated with it. The spatial data is represented by 'X,Y' coordinates in Cartesian space. The crystal orientation data is represented by the three Euler angles. MTEX can handle these data independently.

It is easy to get confused with the crystal and sample orientations in MTEX. It can be useful to first check the results with Aztec Channel 5 or Aztec Crystal, to check they agree.

## Plotting convention

The usual convention for a rolled sample is that X = RD, Y = TD, Z =  ND. And the typical convention for pole figures is to have RD (X axis) NORTH, and TD (Y axis) EAST, which can be done by setting ND (Z axis) into the plane.

```matlab
% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','intoPlane');
```

Or, alternatively, you can set the Y-axis.

```mtalab
setMTEXpref('yAxisDirection','east')
```

Note, this plotting convention affects both the plotting of pole figures AND maps.

## Rotating data

There are different ways to apply rotations to the orientation and spatial data. The most common method is explained here.

A default sample acquisition surface has X (RD) horizontal, Y (TD) vertical and Z (ND) out-of plane. However, in our example case, when the EBSD data was collected in the SEM microscope, the sample was aligned with RD out-of-plane, TD horizontal and ND vertical. So, we apply a phi_1 = 90, PHI = 90 and phi_2 = 0 rotation to realign the Euler angle reference frame for the orientation data. We apply the command `keepXY` to keep the map coordinates as they are and to only change the Euler angle reference frame. 

However, due to our plotting convention (X is north), we find our spatial data (the map) also needs to be rotated, we can do that too. We apply the command `keepEuler` to preserve the Euler angles.

By applying these two rotations, we can be sure that the orientations shown in our pole figures match with the ODF, and that our map is orientated as we would like to view it.

```matlab
rot = rotation('Euler', 90*degree, 90*degree, 0*degree);
ebsd = rotate(ebsd,rot,'keepXY'); % rotate the orientation data
ebsd = rotate(ebsd,90*degree,'keepEuler') % rotate the spatial data
```

## Defining directions

Once you have aligned the orientation data with the correct specimen coordinate system, it can be useful to define the directions in MTEX using the following:

 ```matlab
 % as per convention
 RD = vector3d.X; 
 TD = vector3d.Y;
 ND = vector3d.Z;
 ```

 You can then use these definitions to define model orientations, for example, without confusing vector directions etc.

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
