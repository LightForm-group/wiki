---
title: Common workflows in MTEX
author: Adam Plowman, Sumeet Mishra
subcollection: MTEX
---

MTEX is a Matlab tool for texture analysis. Here are some common workflows in MTEX.

## Generating representative textures

```matlab
clear;
close;
cs = crystalSymmetry('cubic');
ss = specimenSymmetry('orthorhombic');

cube = orientation('Euler',[0,0,0]*degree,cs,ss);
odf_Cube = unimodalODF(cube,'halfwidth',5*degree);
ori1 = calcOrientations(odf_Cube,500);plotPDF(odf_Cube,[Miller(1,1,1,cs)],'antipodal','complete');
```
