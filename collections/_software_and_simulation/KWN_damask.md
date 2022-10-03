---
title: Installing Damask including KWN model  
author: Madeleine Bignon
tags:
  - damask
  - csf
  - Crystal Plasticity
  - Modelling
toc: false
subcollection: KWN precipitation model  
published: true
---
This version of Damask includes a constitutive behaviour law for dynamic precipitation. The program is available [here](https://github.com/LightForm-group/Damask-KWN).

The constitutive law called ```kwnpowerlaw``` allows to consider the evolution of a precipitate distribution under deformation. The evolution of the precipitate distribution during deformation is calculated with a multi-class KWN precipitation kinetics model including the effect of deformation. The strengthening effect of precipitates is taken into account in the calculation of the critical resolved shear stress for dislocation glide. The accelerating effect of deformation on precipitation kinetics is considered using a phenomenological model for excess vacancy production. 

## Installation

The following installation instructions are specific to users of the University of Manchester's Computational Shared Facility (CSF).

- First connect to the CSF
- if it does not already exist, create a ```software``` folder in your ```home``` by running the following command:

```mkdir software```

- Download the files ```load_DAMASK.sh``` and ```load_DAMASK_processing.sh``` from the ```env-script``` folder ([here](https://github.com/LightForm-group/Damask-KWN)) and copy them in your ```home``` folder
- In your home directory, run the following commands:

```source load_DAMASK.sh```

```source load_DAMASK_processing.sh```

- Download the folder called ```damask-kwn``` from [this link](https://github.com/LightForm-group/Damask-KWN) and copy it in your ```software``` directory (or clone it directly from Github)
- Go to the ```software/damask-kwn/``` directory:

```cd software/damask-kwn/```
- Go to the ```src``` directory and remove the hidden files that might have appeared when copying the ```damask-kwn``` folder in the ```software``` directory (this step is not necessary if you used github to clone the folder):

```cd src```

```rm ._*``` 

```cd ..```

- Create a ```build``` directory in ```software/damask-kwn/``` and navigate into it:

``` mkdir build```

``` cd build```

- Run the following command:

```cmake ../ -DDAMASK_SOLVER=GRID -DCMAKE_INSTALL_PREFIX=../```


- Run the following command

```make all install```


## References

