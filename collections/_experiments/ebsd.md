---
published: true
author: Christopher Daniel
title: EBSD
tutorials:
  - Beta reconstruction
  - Cleaning EBSD data
  - EBSD Sample preparation
metadata_templates:
  - ebsd.yml
analysis_codes:
  - name: Example MTEX Scripts 
    link: https://github.com/LightForm-group/Lightform_Mtex
  - name: MTEX texture slice analysis
    link: https://github.com/LightForm-group/MTEX-texture-slice-analysis
---
## General EBSD
This describes the metadata which applies to EBSD experiments. EBSD is a technique where electrons are fired at a sample and the scattering of the electrons is analysed.

### Adjustable Parameters
- Alloy elements (One or more of: Ti, Al, V etc.)
- Sample Orientation Out of Plane (Z1) - (One of: ND(Normal), RD(Rolling), TD(Transverse), CD(Compression), R1(Radial 1), R2(Radial 2), FD(Forging), DD(Draw), ED(Extrusion), RD(Radial), AD(Axial))
- Sample Orientation Up, North (Y1) - (As above)
- Sample Orientation Side, East (X1) - (As above)
- Phase name (One or more of: Ti Hex, Ti Beta, Ti Cubic, Al Cubic etc.)
- Crystal System - (One of: Hexagonal, Cubic)
- Crystal Space Group - (Number)
- Crystal Laue Group - (Text)
- Reflectors - (Number - Default: 40)
- Material Description - (Text)
- Sample Processing Route - (Free text e.g. Rolling, Cast, Uniaxial Compression, Plane Strain, Tension, Forging)
- Tilt - (Number - Default: 70)
- Working Distance (mm) - (Number) 
- Magnification - (Free Number)
- Beam Energy (kV) - (Number - Default: 20)
- Step Size (micrometers) - (Number)
- EBSD Exposure Time (milliseconds) - (Number)
- Overlap of stitched maps (Perentage) - (Number)

### Other notes
- Other notes - (e.g. Stage scan?)
- Storing diffraction patterns?
- Storing chemical composition?

## Setup Specific Metatdata
There are several different microscope setups which have the above data in common but also have some instrument specific metadata.

### TESCAN

- Camera: Oxford Symmetry
- Camera Insertion Distance: 178 mm
- Beam Intensity - (Default: 20) - analagous to probe current.
- Scan Mode - (Resolution, Depth, Field, Wide Field, Channeling)
- Camera Mode - (Resolution, Sensitivity, Speed 1, Speed 2)

### FEI Sirion

- Camera: Oxford NordlysNano
- Camera Insertion Distance: 164.8 mm
- Spot Size - (Default 4, range, integer 1 to 7)
- Aperture - () Combination of the aperture and the spot size is analagous to probe current.
- Binning Mode - (Default 4x4, (1x1, 2x2, 4x4, 8x8, 8x16))
- Gain - (Default: Low, High)
