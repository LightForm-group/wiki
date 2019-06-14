---
title: New version of DAMASK installed on the CSF
author: Adam Plowman
tags:
  - simulation
  - csf
  - damask
toc: true
published: true
---

A new version of DAMASK has been installed on the CSF. The new version offers faster processing of results. Pratheek [says](https://lightform-group.slack.com/archives/CAU3WPSR4/p1559211552003700):

> DAMASK dev update: The HDF5 output format and post processing is now implemented. As some of you have noticed, the post processing of results in DAMASK takes a long time. The new HDF5 implementation is meant to speed things up significantly. Comparing the new postResults for visualizing the equivalent Cauchy stress for 100 increments of a 32x32x32 simulation, the old/current postResults clocked a wall time of 42:17.33 and the new implementation clocked 2:03.77!

## Loading

Load the new version (`v2.0.3-367-g70428155`) with: `module load apps/intel-17.0/damask/devel`

## Differences

When running `DAMASK_spectral`, I've found the following differences between this development version and the older version that is installed on the CSF (version `2.0.2`):

### Output files

- An HDF5 file is now generated during the simulation run.

### `material.config` file

- `<homegenization>` key `type` is now `mech`
- The following `<crystallite>` outputs keys appear to be no longer supported:
  - `e` (total strain as Green-Lagrange tensor)
  - `ee` (elastic strain as Green-Lagrange tensor)
  - `eulerangles` (orientation as Bunge triple)
  - `Volume`
