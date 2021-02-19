---
title: Using DAMASK on the CSF
author: Adam Plowman, Michael Atkinson, Pratheek Shanthraj, Guy Bowker
tags:
  - simulation
  - csf
  - damask
toc: true
published: true
---

The HDF5-compatible version of DAMASK (v3.0.0) should now be working on the CSF. We have installed it in the group RDS space (`/mnt/eps01-rds/jf01-home01/shared/DAMASK-master`). More information about DAMASK, including detail about input and output files etc. may be found at [damask.mpie.de](https://damask.mpie.de).

Not familiar with Manchester University's Computational Shared Facility 3 (CSF3)? You can find more info on how to navigate directories and run computational jobs here: [ri.itservices.manchester.ac.uk/csf3/](http://ri.itservices.manchester.ac.uk/csf3/)

## Running a DAMASK simulation from the command line

To make the `DAMASK_grid` (v3.0) executable available (same function as `DAMASK_spectral` v2), run the following command on the CSF:

```bash
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master.sh
```

To make the `DAMASK_grid` executable available in addition to the the pre-/post-processing commands, run the following command on the CSF:

```bash
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master_processing.sh
```

### Example simulation jobscript

#### Serial job

Place the following jobscript into a directory containing `DAMASK_grid` input files (`.geom`, `.load`, and `material.yaml`) and submit it with `qsub jobscript_name.sh`. Further customisation of the solver may be added in a `numerics.yaml` file if necessary.

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master.sh

#$ -N damask_run          # Name of the job
#$ -cwd                   # Submit in the current working directory

DAMASK_grid -g geom_file_name -l load_case_file_name
```

#### Parallel job

Place the following jobscript into a directory containing `DAMASK_grid` input files (`.geom`, `.load`, and `material.yaml`) and submit it with `qsub jobscript_name`.

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master.sh

#$ -N damask_run          # Name of the job
#$ -cwd                   # Submit in the current working directory
#$ -pe smp.pe 4           # Use a parallel environment with four cores

mpirun -n $NSLOTS DAMASK_grid -g geom_file_name -l load_case_file_name
```
Running a job on the CSF will create two files in the working directory it is run within: A `jobname.o0000000` file, which contains generic job output, and `jobname.e0000000` which contains detail on errors that occured during the run.

### Example post-processing

DAMASK outputs the following files: (`geom_load.C_ref`, `geom_load.hdf5`, and `geom_load.sta`) Using the `.HDF5` file output, we can do processing within Python or a Jupyter notebook instance.
To calculate some useful values from outputs and create a visual representation of the results (`.vtr`), first load the processing environment on the CSF using (as above):

```sh
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master_processing.sh
```
First of all, the .hdf5 output may be navigated from the command line using the command `h5ls`. eg `h5ls geom_load.hdf5/` will list the increments the job has completed.
We can then start a Python instance and, assuming our output HDF5 is called `geom_load.hdf5`, load the HDF5 file into Python. In the following example,
we add the Cauchy stress, which will have a dataset label of `sigma`, and calculated von-Mises stress from this. (found using `h5ls geom_load.hdf5/inc0/phase/(user defined phase)/generic/`)
This new dataset written into the .hdf5 file may then be visualized as a .vtr file that may be opened in paraview:

```python
from subprocess import run, PIPE          # Necessary to place output files into pwd.
import damask                             # Necessary for add_cauchy, to_vtk commands.

f = damask.Result('geom_load.hdf5')

f.add_Cauchy()                            # Calculate Cauchy stress and write into .hdf5 file
f.add_Mises('sigma')                      # Calculate Von-Mises stress and write into .hdf5 file

f.to_vtk(labels=["sigma", "sigma_vM"])    # Write defined datasets into .vtr for each increment
```
Be wary that running this processing script will write the desired values into the .hdf5 file, and upon re-running, there may be an error that the defined values have already been written in. *DONT PANIC!* These calculations will be skipped and any newly defined calculations will be placed in. It is recommended that the user first backup their .hdf5 output file before performing post-processing on it. This will ensure if there are any errors that the original job output file can still be post-processed without having to run the job all over again.

The above *must* be run on the CSF! If we are processing a large output file, we should write a processing script in Python (like that above), and then submit it as a jobscript. If we name our Python script `processing.py`, a processing jobscript might look like this:

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-master_processing.sh

#$ -N damask_processing   # Name of the job
#$ -cwd                   # Submit in the current working directory

python processing.py
```

Note that we can also extract data from the HDF5 file without requiring the DAMASK processing environment (e.g. on our local computer). To do this we need the `h5py` Python package installed. This can be installed using `pip install h5py`. See the [documentation](http://docs.h5py.org/en/stable/) for `h5py` for more details concerning loading an HDF5 file.

## Differences between the current version (3.0.0) and the previous installed version (2.0.3)

- `material.config` files have now been replaced by `material.yaml` files. The syntax of a yaml file can be verified using this tool: [yamlvalidator](https://yamlvalidator.com)

### `material.yaml` file

- Orientations must now be defined using quaternions. Each quaternion component must be to at least 15 dp. (machine precision) eg:

```yaml
- constituents:
  - fraction: 1.0
    orientation: [1.000000000000000, 0.000000000000000, 0.000000000000000, 0.000000000000000]
    phase: Titanium_alpha
  homogenization: SX
```

- Must now follow .yaml/.yml syntax. keys must finish with a colon `:`. The value can then be defined. eg. `c/a: 1.587`
- More detail to follow

## Differences between this version (2.0.3) and the version installed centrally on the CSF (2.0.2)

When running `DAMASK_spectral`, we've found the following differences between this development version and the older version that is installed centrally on the CSF (version `2.0.2`):

### Output files

- An HDF5 file is now generated during the simulation run.

### `material.config` file

- `<homegenization>` key `type` is now `mech`
- `coveraratio` is now `c/a`
- The following `<crystallite>` output keys appear to be no longer supported (or have been renamed?):
  - `e` (total strain as Green-Lagrange tensor)
  - `ee` (elastic strain as Green-Lagrange tensor)
  - `eulerangles` (orientation as Bunge triple)
  - `Volume`
- The `<crystallite>` output keys need to be moved (or copied) to each phase definition section to be output in the hdf5 file
