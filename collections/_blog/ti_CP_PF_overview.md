---
title: "Titanium CP/PF modelling - Project overview"
author: Adam Plowman
tags:
  - titanium
  - crystal-plasticity
  - phase-field
  - dual-phase
published: true
subcollection: Modelling of dual-phase titanium under hot rolling conditions
order: 1
---

*Last updated: July 2021*

The aim of the work is to investigate microstructural evolution of dual-phase titanium (e.g. Ti64) under hot rolling. Ultimately, we aim to develop a coupled crystal plasticity (CP) and phase field (PF) model that can track the kinetics of microstructural development during hot rolling. We will use insight from the model to understand experimental observations, and to provide guidance on the mechanisms at play during hot rolling of these alloys.

The coupled model will be developed as part of the DAMASK crystal plasticity package. However, since this approach will require substantial time for code development and testing, we will, initially, also investigate "static" microstructural transformation. In this case, we will firstly perform CP simulations of a suitable dual-phase representative volume element (RVE). We will then use various methods to identify a region of interest on the deformed RVE, which can then be fed into a phase field-model in order to investigate the kinetics of the microstructure development. For example, we will run a grain-growth model on the region of interest.
