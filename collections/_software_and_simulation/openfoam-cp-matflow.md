---
title: Setting up a Matflow workflow for a CP simulation in the Eulerean_Mechanics OpenFOAM application
author: Maria Yankova
toc: true
tags:
  - openfoam
  - matflow
  - csf3
  - modelling
published: true
subcollection: OpenFOAM
---

This page goes through getting started with the crystal plasticity code
 Eulerean_Mechanics, which is an OpenFOAM application, on the CSF and setting up a Matflow workflow for a simple simulation. 

The instructions have been written assuming the user is on CSF3. Please see further instructions on using OpenFOAM on [CSF3](https://ri.itservices.manchester.ac.uk/csf3/software/applications/openfoam/) and [CSF4](https://ri.itservices.manchester.ac.uk/csf4/software/applications/openfoam/). Please note, there are some errors in the current CSF3 instructions after the transition to SLURM. I have noted these here where relevant and the page will be updated once these have been resolved. 

# 1. Getting started with Eulerean_Mechanics  
Download the code from the [Slip branch](https://github.com/micmog/Eulerian_Mechanics/tree/Slip) and extract it in your home directory.

Load the relevant OpenFOAM module:

```
module purge
module load apps/gcc/openfoam/10
source $foamDotFile

```
Navigate to `solver` and compile via:

```
cd Eulerian_Mechanics-Slip/solver
wclean
wmake

```

# 2. Setting up Matflow 

These instructions follow... 

Make a new Python virtual environment for all your MatFlow work:

```
module load apps/binapps/anaconda3/2024.10
python -m venv matflow_venv

```
Activate the environment:
```
source ./matflow_venv/activate
```
Create a `matflow_requirements.txt` file in your home directory containing the dependencies:
```
    damask==3.0.0a7.post0
    damask-parse
    numpy<2
    matflow-new
```

Install dependencies:
```
pip install -r matflow_requirements.txt

```

Clone the Matflow repository, switch to the OpenFOAM branch and install in editable mode:
```
git clone https://github.com/hpcflow/matflow-new/
cd matflow-new
git switch software/open-foam
pip install --editable .
```

Configure matflow for CSF3:
```
matflow config import github://hpcflow:matflow-configs@main/manchester-CSF3.yaml
```

Make a Matflow environment definitions file at `~/.matflow-new/envs.yaml`, which will define the Matflow environments needed as follows:

```
- name: python_env
  executables:
    - label: python_script
      instances:
        - command: /path/to/matflow_venv/bin/python "<<script_path>>" <<args>>
          num_cores:
            start: 1
            stop: 168
          parallel_mode: null

- name: damask_parse_env
  executables:
    - label: python_script
      instances:
        - command: /path/to/matflow_venv/bin/python "<<script_path>>" <<args>>
          num_cores:
            start: 1
            stop: 168
          parallel_mode: null

- name: OpenFOAM
  setup: |
    module purge
    module load apps/gcc/openfoam/10

    source $foamDotFile
  executables:
    - label: openfoam_app
      instances:
        - command: $APP_PATH <<args>>
          num_cores:
            start: 1
            stop: 168
          parallel_mode: null

```
Further information about Matflow environments can be found at...

Tell MatFlow about the new file: 
```
matflow config append environment_sources ~/.matflow-new/envs.yaml
```
