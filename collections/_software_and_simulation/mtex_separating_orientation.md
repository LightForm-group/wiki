---
title: Separating data by orientation
author: Mia Maric, Christopher Daniel, Nicholas Byres
tags:
  - MTEX
  - MATLAB
  - EBSD
published: true
subcollection: MTEX
---

# Separating data by orientation - the workflow

Data can be separated with respect to it's orientation either for a texture component or a fibre. To do this it is important to know the specimen directions for your data set i.e RD, TD and ND for a rolled material. Data can be separated point by point using the raw data, or by grain. The work flow is as follows:

1. Import your data (you can do this using the import GUI) and rotate/define the specimen directions.

2. Calculate a list of grains and clean the data (if separating by grain).

3. Define the texture orientations (by component/fibre) to be separated.

4. Separate the data.

# Defining the texture orientations

Orientation data can be separated either as a component, that is a single orientation where the crystal plane and a specific direction within that plane are defined or as a fibre where only the orientation of the plane normal is defined. A complete fibre includes all the orentations that share the common plane alignment, whilst a partial fibre is all the orientations that exist between two pre-defined components i.e. a fibre in orientation space that connects to the two. Examples of these are:

1. The rotated cube component - Miller indices {001}<110> and Euler angles phi1=45, PHI=0 and phi2=0.

2. A truncated fibre between the {113}<110> and {111}<110> orientations and

3. The gamma fibre {111} || ND

There are various ways to define these orientations using different commands in MTEX. They are:

orientation.byMiller - defines a component by Miller indices

orientation.byEuler - defines a component by Euler angles

orientation.map - defines a component or fibre by mapping/projecting the plane normal onto a vector direction

and fibre - defines the full fibre by the plane and specimen direction.

The syntax for using each of these commands is as follows:

% components

rotated_cube = orientation.byMiller([0 0 1],[1 1 0],crystal_symmetry); or

rotated_cube = orientation.byEuler(45\*degree,0\*degree,0\*degree,crystal_symmetry) or

rotated_cube = orientation.map((Miller(0, 0, 1,crystal_symmetry), ND, Miller(1, 1, 0,crystal_symmetry), RD);

% a partial fibre

ori1_113_110 = orientation.map(Miller(1, -1, 3,ebsd_Cub), ND, Miller(1, 1, 0,ebsd_Cub), RD);

ori2_111_110 = orientation.map(Miller(1, -1, 1,ebsd_Cub), ND, Miller(1, 1, 0,ebsd_Cub), RD);

f = fibre(ori1_113_110,ori2_111_110);

% a full fibre

Gamma_Fibre = fibre(Miller(1,1,1,crystal_symmetry),ND);

% note - RD and ND in the previous syntax must be predefined e.g.

RD = vector3d.X;
ND = vector3d.Y;
TD = vector3d.Z;

# Separating data by orientation
Once the orientation has been defined in the appropriate way the data can be separated. MTEX achieves this by calculating the angle between the orientation of interest and the orientation of the data points passed to the command. If this lies below a predefined tolererance threshold, the data is allocated to the variable. The easiest way to do this is using the command:

findByOrientation

with the following example syntax:

ebsd_rotated_cube = ebsd('Titanium cubic').findByOrientation(rotated_cube,20\*degree);

# Calculating volume fraction of orientations

The volume fraction of your component/fibre can be calculated from the number of ebsd points within the separated variable.

to find the number of ebsd points within a variable use the command numel:

vol_rotated_cube = numel(ebsd_rotated_cube.x);

# Plotting KAM and orientation on IPF maps
