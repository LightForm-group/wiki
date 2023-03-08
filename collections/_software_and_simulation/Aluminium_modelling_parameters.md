---
title: Al Modelling Parameters
author: Guy Bowker, Laura González Duque
tags:
  - Aluminium
  - DAMASK
  - Crystal Plasticity
  - Modelling
toc: false
subcollection: Aluminium
published: true
---

## Values of crystal plasticity parameters used in different studies.

| Aluminium | $C_{11} (GPa)$ | $C_{12} (GPa)$ | $C_{44} (GPa)$ | $a$ | $n_{sl}=\frac{1}{m}$ | $\dot{\gamma}_0$ | $h_0 (MPa)$ |$h_{ij} (\alpha = \beta)$ |$h_{ij} (\alpha  \neq \beta) $  |  $\tau_0 (MPa)$  |  $\tau_{inf} (MPa)$  | Source  
| -------- | -------- | -------- | -------- | -------- | -------- | -------- | --------- | -------- | -------- | --------- | -------- | ---------
| 6xxx    | 106.43    | 60.35     | 28.21     | 1.354    | 200     | 0.01 s^{-1}    | 411.25       | 1.0 | 1.4 | 46.70        | 104.02        | (M. Khadyko, 2014) [^1] 
| -       | 106.75    | 60.41     | 28.34     | -    | 20     | 0.001 m s^{-1}    | 75       | - | 1.4 | 31        | 63        | (M. Kasemer, 2020) [^2] 
| 1xxx    | 114.30    | 64.30     | 30.75     | 20    | 1.75     | 0.001 s^{-1}    | 1       | - | 1.0 | 88        | 132        | (F. Roters, 2019) [^3] 
| AA6111  | 106.75    | 60.41     | 28.34     | 1.2    | 12     | 0.001 s^{-1}    | 400       | 1.0 | 1.4 | 62        | 152        | (M. Duancheng, 2018) [^4] 

## References

[^1]: M. Khadyko, S. Dumoulin, T. Børvik, O. Hopperstad. An experimental–numerical method to determine the work-hardening of anisotropic ductile materials at large strains. International Journal of Mechanical Sciences 88 (2014) 25–36. https://doi.org/10.1016/j.ijmecsci.2014.07.001

[^2]: M. Kasemer, G. Falkinger, F. Roters. A numerical study of the influence of crystal plasticity modeling parameters on the plastic anisotropy of rolled aluminum sheet. Modelling and Simulation in Materials Science and Engineering 28 (8) (2020) 085005. https://doi.org/10.1088/1361-651X/abb8e2

[^3]: F. Roters, M. Diehl, P. Shanthraj, P. Eisenlohr, C. Reuber, S.L. Wong, T. Maiti, A. Ebrahimi, T. Hochrainer, H.-O. Fabritius, S. Nikolov, M. Friák, N. Fujita, N. Grilli, K.G.F. Janssens, N. Jia, P.J.J. Kok, D. Ma, F. Meier, E. Werner, M. Stricker, D. Weygand, D. Raabe. DAMASK – The Düsseldorf Advanced Material Simulation Kit for modeling multi-physics crystal plasticity, thermal, and damage phenomena from the single crystal up to the component scale. Computational Materials Science 158 (2019) 420-478. https://doi.org/10.1016/j.commatsci.2018.04.030 

[^4]: Ma, Duancheng. "Assessment of full field crystal plasticity finite element method for forming limit diagram prediction." arXiv preprint arXiv:1810.05742 (2018). https://doi.org/10.48550/arXiv.1810.05742
