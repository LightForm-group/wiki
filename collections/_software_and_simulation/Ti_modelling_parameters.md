---
title: Ti Modelling Parameters
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
The model presented uses a constitutive law based on a phenomenological crystal plasticity model described by Pierce et al. (Pierce, 1983). As part of the DAMASK framework (Roters, 2019). A phenomenological model attempts to predict the response one variable has on another, but is not derived from first principles.
The DAMASK full-field crystal plasticity model considers a representative volume element as a continuous body $\mathcal{B}$ consisting of material points located in reference configuration $\textbf{x}\in\mathcal{B}_0$ which move to the current configuration $\textbf{y}\in\mathcal{B}_t$ with deformation.
    An infinitesimal line segment $d\textbf{x}$ is moved by the application of a deformation gradient tensor $F$, which maps $d\textbf{x}$ in the reference configuration to $d\textbf{y}$ in the current configuration. $d\textbf{y} = F(\textbf{x})\cdot d\textbf{x}$.
    Multiplicative decomposition of the deformation gradient tensor splits $F$ into the elastic deformation gradient tensor $F_e$ and plastic deformation gradient tensor $F_p$:
	\begin{equation}\label{equation:1}
		F = F_{e} \cdot F_{p}
	\end{equation}
    
    The elastic deformation gradient tensor $F_e$ is calculated from the Green-Lagrange strain $E$ which is itself determined using Hooke's law:
	\begin{equation}\label{equation:2}
		S = \mathbb{C}:E
	\end{equation}

    Where $S$ is the Cauchy stress tensor and $\mathbb{C}$ is the elastic stiffness tensor. $E$ may then be expressed:
		
	\begin{equation}
		E = \frac{(\boldsymbol{F}_e^T\boldsymbol{F}_e-\boldsymbol{I})}{2}
		\label{eqn:3}
	\end{equation}

    The plastic deformation gradient tensor $F_p$ is calculated using constitutive equations. A constitutive equation describes the response of a specific material to external stimuli. The slip rate $\dot{\gamma}^i$ of polycrystal slip plane $i$ for a given load case is determined as follows:
    
    Equation (\ref{equation:2}) describes the phenomenological power law by which the slip rate $\dot{\gamma}^i$ on some slip system $i$ is dependant upon the initial shear rate $\dot{\gamma}_{0}^{i}$, ratio between resolved shear stress $\tau^i$ and critical resolved shear stress (CRSS) $\xi^i$, inverse of strain rate sensitivity $n_{sl}=\frac{1}{m}$, also known as the stress exponent, and resolved shear stress on the slip system $\tau^{i}$:
        \begin{equation}\label{equation:3}
            \dot{\gamma}^i = \dot{\gamma}_{0}^{i}\displaystyle\left\vert\frac{\tau^i}{\xi^i}\right\vert^{n_{sl}}\text{sgn}(\tau^i)
        \end{equation}

    The CRSS $\xi^i$ in Equation (\ref{equation:3}) is analogous to the yield of slip system $i$. When the resolved shear stress becomes greater than that of the CRSS of the slip system, $\dot{\gamma}^{i}\neq0$ and the slip system begins to slip.
    The resolved shear stress on the system $i$, $\tau^i$, is the second piola-kirchoff stress tensor, $\boldsymbol{S}$, projected by the corresponding schmid tensor, itself given by the dyadic product of the unit vectors along the slip direction, $\boldsymbol{b}^i$, and the slip plane normal, $\boldsymbol{n}^i$:

        \begin{equation}\label{equation:3}
            \tau^i = \boldsymbol{S}\cdot\boldsymbol{b}^i\otimes\boldsymbol{n}^i
        \end{equation}
    
    The following power law is used to determine the change of CRSS $\xi^i$ from its initial value $\xi_0^i$, to the defined saturated CRSS $\xi_\infty^{i^{\prime}}$ with flow hardening as shown in Equation (\ref{equation:4}) and figure \ref{fig:CRSS_evolution}:
        \begin{equation}\label{equation:4}
            \dot{\xi}^i = \dot{h}_0^{s-s}\sum_{i^{\prime}=1}^{N_s} \displaystyle\left\vert\dot{\gamma}^i\right\vert \displaystyle\left\vert1-\frac{\xi^{i^{\prime}}}{\xi_\infty^{i^{\prime}}}\right\vert^{w}sgn(1-\frac{\xi^{i^{\prime}}}{\xi_\infty^{i^{\prime}}})h^{ii^{\prime}}
        \end{equation}

    Where $\dot{h}_0^{s-s}$ is the initial hardening rate, $w$ is a fitting parameter and $h^{ii^{\prime}}$ is the components of the slip-slip interaction matrix. $h_{ij}$ is 1.0 for self-hardening and 1.4 for latent hardening.

Please find below a collection of single crystal property parameters for titanium and its alloys from a variety of literature sources.
Please add to this list should your literature review include these parameters, to aid future work into modelling of titanium and its alloys.


## Alpha phase (Ti-$\alpha$)
Ti-$\alpha$ phase possesses a hexagonal-close packed (HCP) unit cell with $c/a$ ratio 1.587, smaller than the ideal ratio of 1.633 (Lutjering, 2007)[^1].
### Elastic properties

| $C_{11}$ | $C_{12}$ | $C_{13}$ | $C_{33}$ | $C_{44}$ | $C_{66}$ | Source    | Comments                                                                                                                     |
| -------- | -------- | -------- | -------- | -------- | -------- | --------- | ---------------------------------------------------------------------------------------------------------------------------- |
| 162.4    | 92.0     | 69.0     | 180.7    | 46.7     | -        | (Fisher, 1964)[^2] | Ultrasonic wave interference tests of CP-Ti at room temperature. Measurement of $C_{33}$ was interrupted but still included. |
| 160.0    | 95.0     | 45.0     | 181.0    | 55.0     | 55.0     | (Naimon, 1974)[^3] | 'pulse superposition' of Ti64 at room temperature.                                                                           |
| 160.0    | 90.0     | 66.0     | 181.0    | 46.5     | -        | (Hearmon, 1984)[^4] | Collection of crystal parameters from legacy papers |

### Plastic properties - Initial and saturated Critical Resolved Shear Stresses (CRSS)
Be aware some are given as ratios.

| Slip system |   \{ 0002 \}\< 11-20 \>   |   \{ 10-10 \}\< 11-20 \>   |   \{ 10-11 \}\< 11-23 \>   |   Source  | Comments |
| ----------- | --------------------- |  --------------------- | ---------------------- | --------- | -------- |
| CRSS ratio  | 1.5                   |  1                     | 3                      | (Dunst, 1996)[^5] | texture predictions validated eagainst experimental. |
| CRSS        | 420.0                 |  370.0                 | 590.0                  | (Bridier, 2006)[^6] | In-situ fatigue tests of room temperature Ti64. |
| CRSS        | 349.0                 |  150.0                 | 1107.0                 | (Zambaldi, 2012)[^7] | 'Simplex algorythym' used to matchup results of MARC CPFE model with compression tests of room temperature CP-Ti. |
| CRSS        | 444.0                 |  392.0                 | 631.0                 | (Jones, 1981)[^8] | 'Ball model' - estimations of CRSS were validated against uniaxial compression and tensile tests of CP-Ti at room temperature. |

### Plastic properties - Hardening equation parameters

| $a$ | $n_{sl}=\frac{1}{m}$ | $dot{\gamma}_0$ | $h_0$ |  $h_{ij}$  |   Source  | Comments |
| --- | -------------------- | --------------- | ----- | ---------- | --------- | -------- |
| 2.0 | 0.05                 | 0.001           | 200.0 | [1.4 (non-coplanar), 1.0 (coplanar)] | (Zambaldi, 2012)[^7] | Set arbritrarily for use in 'simplex algorythim to determine CRSS' |
|     |                      |                 |       |          |           |          |


## Beta phase (Ti-$\beta$)
Because single-crystal properties of the beta phase cannot be determined directly at room temperature, some assumptions may be made in order to model its deformation response. E.g. Interstitial free steel is a good approximation for the $\beta$-phase, due to possessing similar slip modes.
### Elastic properties

| $C_{11}$ | $C_{12}$ | $C_{44}$ | Source | Comments |
|  ------- | -------- | -------- | ------ | -------- |
|   97.7   |   87.2   |   37.5   | (Ledbetter, 2004)[^9] | non-contacting electromagnetic-acoustic resonance at 1030C. |
|          |          |          |        |          |

### Plastic properties - Initial and saturated Critical Resolved Shear Stresses (CRSS)

| Pencil glide | \{ 110 \}\< 111 \> | \{ 112 \}\< 111 \>| \{ 123 \}\< 111 \> | Source | Comments |
| ------------ | ------------------ | ----------------- | ------------------ | ------ | -------- |
| CRSS ratio   | 1/3                | 1/3               | 1/3                | (Dunst, 1996) [^5] | Hot Texture predictions compared against experimental. |
|              |                    |                   |                    |        |          |

### Plastic properties - Hardening equation parameters

| $w$ | $n_{sl}$ | $dot{\gamma}_0$ | $h_0$ | $h_{ij}$ | Source | Comments |
| --- | -------- | --------------- | ----- | -------- | ------ | -------- |
|     |          |                 |       |          |        |          |
|     |          |                 |       |          |        |          |


## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Dr. Adam Plowman at [Adam.plowman@manchester.ac.uk](mailto:Adam.plowman@manchester.ac.uk) or Guy Bowker at [guy.bowker@postgrad.manchester.ac.uk](mailto:guy.bowker@postgrad.manchester.ac.uk).

## References

[^1]: Lütjering, G. and Williams, J.C., 2007. Titanium. Springer Science & Business Media.
[^2]: Fisher, E.S. and Renken, C.J., 1964. Single-crystal elastic moduli and the hcp→ bcc transformation in Ti, Zr, and Hf. Physical review, 135(2A), p.A482.
[^3]: Naimon, E.R., Weston, W.F. and Ledbetter, H.M., 1974. Elastic properties of two titanium alloys at low temperatures. Cryogenics, 14(5), pp.246-249.
[^4]: Hearmon, R.F.S., 1984. The elastic constants of crystals and other anisotropic materials. Landolt-Bornstein Tables, III/18, 1154.
[^5]: Dunst, D. and Mecking, H., 1996. Analysis of Experimental and Theoretical Rolling Textures of Two-phase Titanium Alloys/Analyse von gemessenen und berechneten Walztexturen bei zweiphasigen Titanbasislegierungen. International Journal of Materials Research, 87(6), pp.498-507.
[^6]: Bridier, F., 2006. Analyse expérimentale des modes de déformation et d'endommagement par fatigue à 20° C d'alliage de titane: aspects cristallographiques à différentes échelles (Doctoral dissertation, Poitiers).
[^7]: Zambaldi, C., Yang, Y., Bieler, T.R. and Raabe, D., 2012. Orientation informed nanoindentation of α-titanium: Indentation pileup in hexagonal metals deforming by prismatic slip. Journal of Materials Research, 27(1), pp.356-367.
[^8]: Jones, I.P. and Hutchinson, W.B., 1981. Stress-state dependence of slip in Titanium-6Al-4V and other HCP metals. Acta Metallurgica, 29(6), pp.951-968.
[^9]: Ledbetter, H., Ogi, H., Kai, S., Kim, S. and Hirao, M., 2004. Elastic constants of body-centered-cubic titanium monocrystals. Journal of applied physics, 95(9), pp.4642-4644.





