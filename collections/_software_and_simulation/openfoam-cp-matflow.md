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

The instructions have been written assuming the user is on CSF3. Please see further instructions on using OpenFOAM on [CSF3](https://ri.itservices.manchester.ac.uk/csf3/software/applications/openfoam/) and [CSF4](https://ri.itservices.manchester.ac.uk/csf4/software/applications/openfoam/). Please note, there are some errors in the current CSF3 instructions after the transition to SLURM. 

# 1. Getting started with Eulerean_Mechanics
## 1.1. Download and compile
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
Note Aug 2025: If the most current version does not compile, see below for an alternative. 

## 1.2. Alternatively, copy a precompiled version
You can find the necessary files in `/mnt/eps01-rds/jf01-home01/shared/Eulerean_Mechanics`.

Copy the `Euler_Solid_MechFoam_Oct24` file to the following location in your home directory on the CSF:
```
/OpenFOAM/<YOURUserID>-10/platforms/linux64GccDPInt32Opt/bin
```
*(where `<YOURUserID>` stands for your actual user ID)*

Run `chmod +x Euler_Solid_MechFoam_Oct24`.

Copy the other files starting with `lib*` into 
```
/OpenFOAM/<YOURUserID>-10/platforms/linux64GccDPInt32Opt/lib
```


# 2. Setting up Matflow 

Make a new Python virtual environment for all your MatFlow work:

```
module load apps/binapps/anaconda3/2024.10
python -m venv matflow_venv

```
Activate the environment:
```
source ~/matflow_venv/bin/activate

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
Further information about Matflow environments can be found [here](https://docs.matflow.io/stable/installation.html#environments).

Tell MatFlow about the new file: 
```
matflow config append environment_sources ~/.matflow-new/envs.yaml
```

Check the configuration file via:
```
matflow config get --all
```
# 3. Running a workflow
Copy the `open_foam_CP.yaml` workflow from `$HOME/matflow-new/matflow/data/workflows` to an appropriate location on `scratch`, where you plan to run your simulations.

Currently, the workflow provides a path (called `root_path`) to the inputs from an example simulation, where these inputs are copied from, i.e. the `system`, `initial` and `constant` folders. Please adjust `root_path` accordingly. To get started, you can find some examples in `Eulerian_Mechanics/tutorials/`.

Another parameter that might need adjusting is the `app_name`. If the code is compiled as is, the default name is `Euler_Solid_MechFoam`. If either using the pre-compiled version (`Euler_Solid_MechFoam_Oct24`) or your own, please adjust. 

Please note, once the development work is finished, the `template_components` part will go in the data template components directory under Matflow but for ease it is kept within the workflow currently. 

The workflow consists of three tasks:
1) `generate_volume_element_from_voronoi`- this task creates a box for the volume element, then discretises it according to `VE_grid_size`. `Position` define the positions of the seed points, from which a Voronoi tesselation is then applied using DAMASK's Python processing library.    
Please note, the orientations are directly passed to avoid the issue of the currently different formats between Matflow and Eulerian_Mechanics.
2) `visualise_VE_VTK` - the geometry `.vti` file is created, which can be visualised in ParaView.
3) `simulate_VE_loading_OpenFOAM` - perform the OpenFOAM simulation.
The steps that the task follows can be traced in the `task_schemas`, where firstly the `input_file_generators` are run, followed by the `commands`.
 Currently, there are three input file scripts, which can be found in `matflow/data/scripts/open_foam` and as the workflow is expanded to programmatically generate the rest of the OpenFOAM input files, further scripts will be needed/might be combined into one. As an example, `write_phase_ID_files.py` uses `from_inputs: [volume element]` to generate the input files defined in `input_file: open_foam_phase_bool_files`, i.e. the individual grain field files `n.*`. The commands then follow the commands we would usually run in a jobscript file. Please note, further parametrisation is still needed, so for instance, if you wish to adjust the number of cores for the parallel simulation, you need to manually adjust the parameters in `decomposeParDict`, where `numberOfSubdomains` corresponds to the number of cores and these need to be split correctly in the different directions `simpleCoeffs `: ```{
    n               (1 2 1);}```.
 
To get started firstly, activate the Matflow environment:
```
 source ~/matflow_venv/bin/activate
```

Next, run the workflow via:
```
 matflow go open_foam_CP.yaml
```

You can track the workflow progress via:
```
 matflow show
```
You can find the outputs under `execute`:
* `t_1` contains the VTK file of the created geometry
* `t_2` contains the OpenFOAM simulation inputs and outputs

To cancel a running worflow use the workflow ID as found using `matflow show` (or the path):
```
 matflow cancel <ID>
```


