---
title: Modelling Parameters
author: Guy Bowker, Adam Plowman
tags:
  - Titanium
  - DAMASK
  - Crystal Plasticity
  - Modelling
toc: false
subcollection: Titanium
published: true
---

Constitutive Crystal Plasticity models are reliant on two equations as part of a phenomenological power law:

Equation 1 describes the constitutive power law by which the slip rate $\dot{\gamma}$ on some arbitrary labelled slip system $i$ is dependant upon the initial shear rate $\dot{\gamma}_{0}^{i}$, ratio between initial $\tau^i$ and saturated $\xi^i$ CRSS values, inverse of strain rate sensitivity $n=\frac{1}{m}$, and shear stress on the slip system:

	\[ \dot{\gamma}^i = \dot{\gamma}_{0}^{i}\displaystyle\left\lvert \frac{\tau^i}{\xi^i}\right\vert^n \text{sgn}(\tau^i) \]
	
The saturated critical resolved shear stress ($\xi^i$) in this equation is reliant on Equation 2, which calculates the rate of hardening of the slip system with deformation:

	\[ \dot{\xi}^i = \dot{h}_0^{s-s}(1+h_{int}^i)\sum_{i'=1}^{N_s} \displaystyle\left\lvert\dot{\gamma}^i\right\vert \displaystyle\left\lvert1-\frac{\xi^i'}{\xi_\infty^i'}\right\vert^w sgn(1-\frac{\xi^i'}{\xi_\infty^i'})h^ii' \]

Please find below a collection of single crystal property parametters for Titanium and its alloys from a variety of literature sources.
Please add to this list should your literature review include these parameters, to aid future work into modelling of titanium and its alloys.


## Alpha phase (Ti-$\alpha$)
### Elastic properties

| $C_{11}$ | $C_{12}$ | $C_{13}$ | $C_{33}$ | $C_{44}$ | $C_{66}$ | Source | Comments |
| -------- | -------- | -------- | -------- | -------- | -------- | ------ | -------- |
| 162.4    | 92.0     | 69.0     | 180.7    | 46.7     |          | [1]    | Ultrasonic wave interference tests of CP-Ti at room temperature. Measurement of $C_{33}$ was interrupted but still included. |

### Plastic properties - Initial and saturated Critical Resolved Shear Stresses (CRSS)

| Slip system | \{ 0002 \}\< 11-20 \> | \{ 10-10 \}\< 11-20 \> | \{ 10-11 \}\< 11-23 \> | Source | Comments |
| ----------- | --------------------- |  --------------------- | ---------------------- | ------ | -------- |
| CRSS        |                       |                        |                        |        |          |

### Plastic properties - Hardening equation parameters

| $w$ | $n_{sl}$ | $dot{\gamma}_0$ | $h_0$ | $h_{ij}$ | Source | Comments |
| --- | -------- | --------------- | ----- | -------- | ------ | -------- |
|     |          |                 |       |          |        |          |


## Beta phase (Ti-$\beta$)
### Elastic properties

| $C_{11}$ | $C_{12}$ | $C_{44}$ | Source | Comments |
|  ------- | -------- | -------- | ------ | -------- |
|          |          |          |        |          |

### Plastic properties - Initial and saturated Critical Resolved Shear Stresses (CRSS)

| Pencil glide | \{ 110 \}\< 111 \> | \{ 112 \}\< 111 \> | \{ 123 \}\< 111 \> | Source | Comments |
| ------------ | ------------------ |  ----------------- | ------------------ | ------ | -------- |
|     CRSS     |                    |                    |                    |        |          |

### Plastic properties - Hardening equation parameters

| $w$ | $n_{sl}$ | $dot{\gamma}_0$ | $h_0$ | $h_{ij}$ | Source | Comments |
| --- | -------- | --------------- | ----- | -------- | ------ | -------- |
|     |          |                 |       |          |        |          |


## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Dr. Adam Plowman at [Adam.plowman@manchester.ac.uk](mailto:Adam.plowman@manchester.ac.uk) or Guy Bowker at [guy.bowker@postgrad.manchester.ac.uk](mailto:guy.bowker@postgrad.manchester.ac.uk).

## References

[1] Fisher, E.S. and Renken, C.J., 1964. Single-crystal elastic moduli and the hcp→ bcc transformation in Ti, Zr, and Hf. Physical review, 135(2A), p.A482.


