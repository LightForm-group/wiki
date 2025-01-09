---
title: Running DAMASK with MatFlow
author: Guy Bowker
toc: true
tags:
  - python
  - matflow-old
  - damask
published: true
subcollection: DAMASK
---

## Running DAMASK with Matflow

DAMASK can be used in combination with dream3D, DefDap, and MTEX with MatFlow. See [here](https://github.com/LightForm-group/UoM-CSF-matflow/blob/master/workflows/tension_DAMASK_Al.yml) for an example and [here](https://lightform-group.github.io/wiki/software_and_simulation/matflow-first-time) for a guide.

## Common issues with matflow-damask

Before Running your MatFlow-DAMASK workflow ensure your `workflow.yaml` file is valid with [this free online tool](https://www.yamllint.com/).
Ensure you use the `spectral_polarization` flag to use the latest solver:
```yaml
  - name: simulate_volume_element_loading
    method: CP_FFT
    software: DAMASK
    base:
      solver:
	mechanical: spectral_polarization # spectral_basic(default), spectral_polarization, FEM
      numerics:
        grid:
          itmax: 100 # number of allowed attempts to converge
          maxCutBack: 1 # number of times allowed to cutback
          derivative: FWBW_difference # uses smoother diffrential
```
