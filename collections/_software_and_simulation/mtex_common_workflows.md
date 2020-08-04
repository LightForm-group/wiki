---
title: Common workflows in MTEX
author: Adam Plowman, Sumeet Mishra, Christopher Daniel, Nicholas Byres
subcollection: MTEX
---

MTEX is a Matlab tool for texture analysis. Here are some common workflows in MTEX.

## Rotating data

Each EBSD data point has various meta-data associated with it. Texture concerns the distribution of orientations in 3D space and of primary importance are the orientation data, represented by three Euler angles, and the spatial data represented by 'XY' coordinates in Cartesian space. MTEX can deal with these data independently. 

Firstly we must ensure the crystal orientations, i.e. the Euler angles, are with respect to the accepted normal specimen coordinate system and not some arbitrary coordinate system. This means a rotation may need to be applied to the orientation data. At this point, you must know the default X and Y directions of the microscope used to obtain your data, and the orientation of your specimen when it was placed into the microsope - and thus the orientation of the acquisition surface.

The usual convention for a rolled sample is that X is alligned with RD, Y with TD and Z with ND. If your sample was placed into the microscope with this orientation, there is no need to apply a rotation to the orientation data. However, if the acquisition surface was different to this i.e. with RD in Y and TD in Z, a rotation must be applied. In this instance the rotation will be phi1 = 0, PHI = -90 and phi2 = -90.

To do this the following syntax can be used:

```matlab
rot = rotation('Euler', 0*degree, -90*degree, -90*degree);
ebsd = rotate(ebsd,rot,'keepXY'); % rotate the orientation data
ebsd = rotate(ebsd,90*degree,'keepEuler') % rotate the spatial data
```

The flag 'keepXY' that is being passed to the 'rotate' command, ensures MTEX only rotates the orientation data and not the spatial data. The flag 'keepEuler' can be used in the same manner so that the second rotation only rotates the spatial data.

To visualise your data in a map that is aligned as it were in the microscope, you can define the plotting conventions by:

```matlab
% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');
```

However, the plotting convention affects both the plotting of maps AND pole figures. As long as our orientation data is in line with convention i.e. with the correct rotation applied, the above plotting convention would result in a pole figure that was plotted with RD east and TD south (I think!), which is not the normal convention. It is possible to change the plotting convention so that 'X' and 'Y' (and therefore RD and TD) are in the correct locations on the pole figure using the same format:

```matlab
% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('yAxisDirection','east');
```

Changing the plotting convention will rotate your orientation data with respect to the 2D plane of the pole figure plot - but not with respect to the specimen coordinate system, as this will thuse be rotated with orientation data. This can be a source of confusion when first looking at texture data in MTEX. It is advised to check your textures against Aztec analyses to ensure your definitions are correct.

Once you have established your orientation data with respect to the correct specimen coordinate system - it can be useful to define the directions in MTEX using the following:

```matlab
% as per convention
RD = vector3d.X; 
TD = vector3d.Y;
ND = vector3d.Z;
```

You can then use these definitions to define model orientations for example, without confusing vector directions etc.

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
