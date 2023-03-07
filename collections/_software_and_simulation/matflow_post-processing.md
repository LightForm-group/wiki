---
title: Post-processing a Matflow Workflow
author: Guy Bowker
toc: true
tags:
  - python
  - jupyter
  - matflow
  - damask
published: true
subcollection: MatFlow
---

## Exploring matflow workflow metadata and results
Matflow outputs all metadata and volume element dimensions, orientation data, single crystal parameters and simulation results in a HDF file named `workflow.hdf5`, this file can be explored in two ways:

Firstly, using the HDF view program, which can be downloaded [here](https://www.hdfgroup.org/downloads/hdfview/#download).
Right click the `workflow.hdf5` file in your file explorer and `open with HDFview`.
In the dropdown select `element_data`. Simulation results can be found under `simulate_volume_element_loading`.

Secondly, using python. Open a jupyter notebook and define the filepath to the directory containing the `workflow.hdf5` file as a string.
import the matflow library and use load_workflow to extract the `workflow.hdf5` file's data as a python dictionary:
```python
from matflow import load_workflow
workflow_dir = "some_workflow_2023-02-07-153700/"
workflow = load_workflow(workflow_dir)
ve_response = workflow.tasks.simulate_volume_element_loading.elements[0].outputs.volume_element_response
```
You can then explore and save aspects of the metadata and results to variables in python as shown for `ve_response`.
