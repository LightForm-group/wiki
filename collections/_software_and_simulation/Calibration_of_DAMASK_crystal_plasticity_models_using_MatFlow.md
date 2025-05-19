---
title: Calibration of DAMASK crystal plasticity models using MatFlow
author: Matty Warner
toc: true
published: true
tags:
- damask
- matflow
subcollection: DAMASK
---
This page aims to show how to calibrate crystal plasticity models in DAMASK using a stress-strain data from an experimental tensile test with a MatFlow workflow.

## Crystal Plasticity Models
Phenomenological and dislocation density-based crystal plasticity models are both used to simulate deformation in crystalline structures. The phenomenological model uses a macroscopic picture of deformation, with a power law associating the resolved shear stress on a given slip system with the shear rate. The dislocation density model is a physics-based formulation that calculates the shear rate from the interaction between dislocations and slip systems. Both models involve fitting parameters that must be calibrated with respect to experimental data in order to run physically meaningful simulations.
