---
title: Using Python on the CSF for Post-processing
author: Yuchen Zheng
tags:
  - simulation
  - csf
  - damask
  - python
toc: true
published: true
subcollection: DAMASK
---

This content is an addition to the previous section [here](https://lightform-group.github.io/wiki/software_and_simulation/new-damask).

After getting the `geom_load.hdf5` file as the result of DAMASK simulation. We can do processing with Python codes on CSF.

### Output .vti File from .hdf5
`.vti` file is used to store series of image data, which can be exported during post-processing and visualised by ParaView. Here is a detailed example can be named
`postprocessing.py`(You may create a new folder and make the file):

```python
import damask                                           # Necessary for .add, .export_VTK commands.
import numpy as np                                      # Necessary for sort out the axes.

f = damask.Result('/path/to/geom_load.hdf5')            # Find the .hdf5 file.

l1 = np.array([1,0,0])                                  # Represent X axis.
l2 = np.array([0,1,0])                                  # Represent Y axis.
l3 = np.array([0,0,1])                                  # Represent Z axis.
for inc in [0, 10, 20, 30, 40]:                         # Depends on which time-points you want to visaulise, e.g. the 5 time-points from step 0 to 40. 
  f_inc = f.view(increments=inc)
  f_inc.add_stress_Cauchy()                             # Calculate Cauchy stress and write into .hdf5 file
  f_inc.add_equivalent_Mises('sigma')                   # Calculate Von-Mises stress and write into .hdf5 file
  f_inc.add_equivalent_Mises('epsilon_V^0.0(F)')        # Calculate equivalent strain and write into .hdf5 file
  f_inc.add_IPF_color(l=l1)                             # Apply IPF colours along X to RVE.
  f_inc.add_IPF_color(l=l2)                             # Apply IPF colours along Y to RVE.
  f_inc.add_IPF_color(l=l3)                             # Apply IPF colours along Z to RVE.
  f_inc.export_VTK(output=['sigma', 'epsilon_V^0.0(F)', 'O', 'IPFcolor_(1 0 0)','IPFcolor_(0 1 0)','IPFcolor_(0 0 1)', 'phi'])   # Export .vti with the parameters added above.
  print(f_inc.list_data())                              # Show existed dataset.
```
We can modify it by adding more parameters we need to analyse. It is worth to mention that though the command is called `.export_VTK`, the output file is in the
format of '.vti', not `.vtk` or `.vtr`. It is a standard output format of the latest damask module.

Don't `.add` the same parameters twice otherwise there will be errors. A good way to check if the dataset already existed is `print(f_inc.list_data())` where we can check all the parameters we added before.

### Output Stress vs Strain Curve from .hdf5
Write another python script or just add the following lines to the `postprocessing.py`:

```python
import damask
import matplotlib.pyplot as plt

f = damask.Result('/path/to/geom_load.hdf5')                               # Find the .hdf5 file.
f.view(increments=-1).get().keys()                                         # Aanlysis the last step.
sigma = [np.average(s) for s in f.get('sigma_vM').values()]                # Acess the stress.
epsilon = [np.average(e) for e in f.get('epsilon_V^0.0(F)_vM').values()]   # Acess the strain.
plt.plot(epsilon,sigma)                                                    # Plot Stress vs Strain Curve.
plt.savefig('stress_vs_strain_plot.png')                                   # Save the picture.
```

### Submit task to CSF
The `postprocessing.py` can be run by the command 'python postprocessing.py', however, when the .hdf5 file is big in size, it would take ages to complete the processing.
Therefore, it is better to use a parallel environment to run the task by create another file 'postprocessing_jobscript.sh':

```sh
#!/bin/bash --login
#$ -cwd                                                 # Submit in the current working directory
#$ -pe smp.pe 4                                         # Use a parallel environment with 4 cores
#$ -l short                                             # Select type of core, use mem512 when the task is huge.

module load apps/binapps/anaconda3/2021.11              # Load Anaconda
source activate /mnt/eps01-rds/jf01-home01/shared/.conda/damask_v3a7      # Activate the conda environment, can be change to other envs.

python postprocessing.py interactive                   # Run with Python
```
Then we can type the command `qsub postprocessing_jobscript.sh` to submit the task to CSF.
