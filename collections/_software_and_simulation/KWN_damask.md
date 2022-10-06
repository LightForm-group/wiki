---
title: Damask version including KWN model for precipitation kinetics
author: Madeleine Bignon
tags:
  - damask
  - csf
  - Crystal Plasticity
  - Modelling
toc: false
subcollection: 
  - KWN precipitation model  
  - DAMASK
published: true
---
This version of Damask includes a constitutive behaviour law for dynamic precipitation. The program is available [here](https://github.com/LightForm-group/Damask-KWN).

The constitutive law called ```kwnpowerlaw``` allows to consider the evolution of a precipitate distribution under deformation. The evolution of the precipitate distribution is calculated with a multi-class KWN precipitation kinetics model. The strengthening effect of precipitates is taken into account in the calculation of the critical resolved shear stress for dislocation glide. The accelerating effect of deformation on precipitation kinetics is considered using a phenomenological model for excess vacancy production. 

The documentation of the model can be downloaded [here](https://github.com/LightForm-group/Damask-KWN/blob/main/model_documentation/fullfield-kwn.pdf)

## Installation

The following installation instructions are specific to users of the University of Manchester's Computational Shared Facility (CSF).

- First connect to the CSF
- if it does not already exist, create a ```software``` folder in your ```home``` by running the following command:

```bash
mkdir software
```

- Download the files ```load_DAMASK.sh``` and ```load_DAMASK_processing.sh``` from the ```env-script``` folder ([here](https://github.com/LightForm-group/Damask-KWN)) and copy them in your ```home``` folder
- In your home directory, run the following commands:

```bash
source load_DAMASK_processing.sh
```

- Download the folder called ```damask-kwn``` from [this link](https://github.com/LightForm-group/Damask-KWN) and copy it in your ```software``` directory (or clone it directly from Github)
- Go to the ```software/damask-kwn/``` directory:

```bash
cd software/damask-kwn/
```
- Go to the ```src``` directory and remove the hidden files that might have appeared when copying the ```damask-kwn``` folder in the ```software``` directory (this step is not necessary if you used github to clone the folder):

```bash
cd src
rm ._*
cd ..
```

- Create a ```build``` directory in ```software/damask-kwn/``` and navigate into it:

```bash
mkdir build
```

```bash
cd build
```

- Run the following command:

```bash
cmake ../ -DDAMASK_SOLVER=GRID -DCMAKE_INSTALL_PREFIX=../
```


- Run the following command

```bash
make all install
```

## Running simulations 

First of all, open the CSF and run the following command:

```bash
source /mnt/eps01-rds/jf01-home01/shared/load_DAMASK-processing.sh
```
### Running a job 


Place the following jobscript into a directory containing `DAMASK` input files (`geom.vtr`, `load.yaml`, and `material.yaml`) and submit it with `qsub jobscript_name`.

```sh
#!/bin/bash --login
#$ -cwd                   # Submit in the current working directory
#$ -pe smp.pe 4           # Use a parallel environment with four cores

source ~/load_DAMASK.sh

mpirun -n $NSLOTS DAMASK_grid -l load.yaml -g geom.vtr
```
Running a job on the CSF will create two files in the working directory it is run within: A `jobname.o0000000` file, which contains generic job output, and `jobname.e0000000` which contains detail on errors that occured during the run.

A set of examples files (`geom.vtr`, `load.yaml`, `material.yaml` and `jobscript.sh` files) is available in the ```example_of_use``` directory [here](https://github.com/LightForm-group/Damask-KWN)
### Input files examples

The ```material.yaml``` file contains all the material properties. It also contains all the parameters of the KWN dynamic precipitation model (please note that the temperature is defined in the ```load.yaml``` file). The documentation detailing the meaning of the inputs is available [here](https://github.com/LightForm-group/Damask-KWN/blob/main/model_documentation/fullfield-kwn.pdf).

Example ```material.yaml``` file (for a simulation with 4 grains)
```yaml
homogenization:
  SX:
    N_constituents: 1
    mechanical:
      type: pass
    thermal:
      type: pass
      
material:
- constituents:
  - O:
    - 0.19813654684736873
    - -0.4003702989793671
    - 0.38708148638970563
    - -0.806606133991621
    phase: Aluminum
    v: 1.0
  homogenization: SX
- constituents:
  - O:
    - 0.4131826988800702
    - -0.6684243946439803
    - 0.5135613787035137
    - 0.34459192720543513
    phase: Aluminum
    v: 1.0
  homogenization: SX
- constituents:
  - O:
    - 0.21956653913118745
    - -0.3396582332002957
    - 0.5011663510132476
    - -0.765019678260156
    phase: Aluminum
    v: 1.0
  homogenization: SX
- constituents:
  - O:
    - 0.2487765086598615
    - -0.8408812909074685
    - 0.44711671323124785
    - 0.17639599794237146
    phase: Aluminum
    v: 1.0
    
    
phase:
  Aluminum:
    lattice: cF
    mechanical:
      elastic:
        C_11: 100000000000.0
        C_12: 60410000000.0
        C_44: 28340000000.0
        type: Hooke
      output:
      - F
      - P
      - F_e
      - F_p
      - L_p
      - O
      plastic:
        N_sl:
        - 12
        a_sl: 2.25
        atol_precipitate_density: 1e-12
        atol_solute: 1e-12
        atol_xi: 1.0
        atomic_volume: 1.66e-29
        burgers_vector: 2.9e-10
        c0_matrix:
        - 0.02889
        - 0.02406
        ceq_matrix:
        - 0.012082196019601959
        - 0.0005296453049830318
        ceq_precipitate:
        - 0.27
        - 0.38
        dislocation_arrangement: 1
        dot_gamma_0_sl: 0.001
        gamma_coherent: 0.265
        h_0_sl_sl: 589020809.2851744
        h_sl_sl:
        - 1
        - 1
        - 1.4
        - 1.4
        - 1.4
        - 1.4
        - 1.4
        initial_dislocation_density: 100000000000000.0
        initial_mean_radius: 9.0e-10
        initial_volume_fraction: 0.007
        jog_formation_energy: 4.806529901999999e-20
        kwn_nsteps: 60
        kwn_step0: 5
        kwn_stepsize: 0.5
        lattice_parameter: 4.0695e-10
        misfit_energy: 0
        molar_volume: 1e-05
        n_sl: 50.0
        output:
        - gamma_sl
        - phi_total
        - phi
        - solute_c
        - r_avg
        - xi_sl
        - vacancy_c
        - f
        precipitate_strength_constant: 0.03535
        transition_radius: 3.3e-9
        shear_modulus: 28340000000.0
        solute_diffusion0: 1.49e-05
        solute_migration_energy: 2.0923e-19
        solute_strength: 683000000.0
        standard_deviation: 2.01322e-10
        stoechiometry:
        - 5
        - 7
        - 6
        type: kwnpowerlaw
        vacancy_diffusion0: 1e-05
        vacancy_energy: 8.331e-20
        vacancy_generation: 0.035
        vacancy_migration_energy: 1.49e-19
        vacancy_sink_spacing: 5e-05
        xi_0_sl:
        - 7800000.0
        xi_inf_sl:
        - 210330547.0653053
    rho: 1.0
    thermal:
      C_p: 1.0

```

The ```load.yaml``` file contains the deformation conditions as well as the temperature.

Example ```load.yaml``` file
```yaml
initial_conditions:
  thermal:
    T: 423.0
loadstep:
- boundary_conditions:
    mechanical:
      P:
      - x
      - x
      - x
      - x
      - 0
      - x
      - x
      - x
      - 0
      dot_F:
      - 0.0001
      - 0
      - 0
      - 0
      - x
      - 0
      - 0
      - 0
      - x
  discretization:
    N: 10000
    t: 2000
  f_out: 100

  
solver:
  mechanical: spectral_basic
  thermal: spectral
  ```
## Post-processing

Some post-processing tools are available in the ```env_scripts``` directory from [this repository](https://github.com/LightForm-group/Damask-KWN).
To use them, copy the ```post_processing.py``` and ```notebook_post_processing.ipynb``` in the folder containing the result file (which has ```.hdf5``` extension).

To create textfiles containing the results of the calculation, as well as ```.vtr``` files allowing to display the result in 3D (e.g. with Paraview), go with the CSF to the folder containing the result file (```geom_load.hdf5``` in the example below) and run the following command:

```bash
python post_processing.py geom_load.hdf5
```
This will create a textfile per variable and per time increment containing the value of the given variables for all voxels of the simulation. For example, if the simulation is run with a 16x16x16 (=4096) box, the file ```vf_100``` contains 4096 lines for the calculated volume fractions of the 4096 elements of the simulation at increment time 100.

Additionally, the jupyter notebook ```notebook_post_processing.ipynb``` can be copied in the folder containing the result file and run to display some calculation results. 

