---
title: Using DAMASK on the CSF
author: Adam Plowman, Michael Atkinson, Pratheek Shanthraj
tags:
  - simulation
  - csf
  - damask
toc: true
published: true
---

The HDF5-compatible version of DAMASK (v2.0.3) should now be working on the CSF. We have installed it in the group RDS space (`/mnt/eps01-rds/jf01-home01/shared/DAMASK`).

## Usage

To make the `DAMASK_spectral` executable available, run the following command on the CSF:

```bash
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK.sh
```

To make the `DAMASK_spectral` executable available in addition to the the pre-/post-processing commands, run the following command on the CSF:

```bash
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK_processing.sh
```

### Example simulation jobscript

#### Serial job

Place the following jobscript into a directory in which there are `DAMASK_spectral` input files (a geometry file, a load file and a `material.config` file) and submit it with `qsub jobscript_name`.

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK.sh

#$ -N damask_run          # Name of the job
#$ -cwd                   # Submit in the current working directory

DAMASK_spectral -g geom_file_name -l load_case_file_name
```

#### Parallel job

Place the following jobscript into a directory in which there are `DAMASK_spectral` input files (a geometry file, a load file and a `material.config` file) and submit it with `qsub jobscript_name`.

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK.sh

#$ -N damask_run          # Name of the job
#$ -cwd                   # Submit in the current working directory
#$ -pe smp.pe 4           # Use a parallel environment with four cores

mpirun -n $NSLOTS DAMASK_spectral -g geom_file_name -l load_case_file_name
```

### Example post-processing

Using the HDF5 file output, we can do processing within Python or a Jupyter notebook instance. 

Firstly, load the processing environment on the CSF using (as above):

```sh
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK_processing.sh
```

We can then start a Python instance and, assuming our output HDF5 is called `geom_load.hdf5`, load the HDF5 file into Python. In the following example,
we add the Cauchy stress (which will have a label of `sigma`), and then the von Mises Cauchy stress:

```python
import damask

f = damask.DAD5('geom_load.hdf5')

f.add_Cauchy()
f.add_Mises('sigma')
```

The above must be run on the CSF. If we are processing a large output file, we should write a processing script in Python (like that above), and then submit it as a jobscript. If we name our Python script `processing.py`, a processing jobscript might look like this:

```sh
#!/bin/bash --login

source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK_processing.sh

#$ -N damask_processing   # Name of the job
#$ -cwd                   # Submit in the current working directory

python processing.py
```

Note that we can also extract data from the HDF5 file without requiring the DAMASK processing environment (e.g. on our local computer). To do this we need the following `h5py` Python package installed. This can be installed using `pip install h5py`. See the [documentation](http://docs.h5py.org/en/stable/) for `h5py` for more details concerning loading an HDF5 file.

## Differences between this version (2.0.3) and the version installed centrally on the CSF (2.0.2)

When running `DAMASK_spectral`, we've found the following differences between this development version and the older version that is installed centrally on the CSF (version `2.0.2`):

### Output files

- An HDF5 file is now generated during the simulation run.

### `material.config` file

- `<homegenization>` key `type` is now `mech`
- The following `<crystallite>` output keys appear to be no longer supported (or have been renamed?):
  - `e` (total strain as Green-Lagrange tensor)
  - `ee` (elastic strain as Green-Lagrange tensor)
  - `eulerangles` (orientation as Bunge triple)
  - `Volume`
- The `<crystallite>` output keys need to be moved (or copied) to each phase definition section to be output in the hdf5 file
