---
title: Installing PETSc and DAMASK on the CSF3
author: Samuel Engel
tags:
  - DAMASK
  - PETSc
  - CSF3
  - Crystal Plasticity
  - Modelling
toc: false
subcollection: 
  - DAMASK
published: true
---

This page aims to detail how to install PETSc (https://petsc.org/release/) and DAMASK (https://damask-multiphysics.org/) for simulating crystal plasticity.


## Edit Bash Profile
Before we begin, it is important to define some enviroment variables, these should be added to your `.bash_profile`, which can be accessed using the following commands.

```
cd

vim .bash_profile
```
With the editor open, add the following lines of code to the bottom

```
export HDF5_USE_FILE_LOCKING=FALSE

export PETSC_DIR=$HOME/software/petsc
export PETSC_ARCH=mkl-opt

export PATH=$PETSC_DIR/$PETSC_ARCH/bin:$PATH
```

Make sure to save and exit, you will need to logout and log back in for the changes to take effect. 

## Install PETSc

Now, we need to download and install PETSc, if you don't already have a software folder on the CSF3, then ensure you make on in your home directory. Once downloaded, it's important to make sure you are on the correct branch.

```
cd

mkdir software

cd software

git clone https://github.com/petsc/petsc.git

cd petsc

git checkout release-3.19
```

Now that we have PETSc downloaded we need to configure it for use with DAMASK. We need to create a folder within PETSc to hold extra packaged required by DAMASK. This should be within the PETSc directory `software/petsc/mkl-opt`.

```
cd $PETSC_DIR

mkdir mkl-opt
```

When configuring PETSc, it's best to either do so interactively or using a submission script. Here, we use a submission script that we can call `configure_petsc.sh`.

```
#!/bin/bash --login

#$ -cwd
#$ -N configure_petsc

# Exports
export HDF5_USE_FILE_LOCKING=FALSE

# contains:
module purge

module load mpi/intel-19.1/openmpi/4.1.1
module load tools/gcc/cmake/3.13.2

cd $PETSC_DIR

## For CSF3
./configure \
--with-cc=mpicc \
--with-cxx=mpicxx \
--with-fc=mpif90 \
--download-fftw \
--download-hdf5 \
--download-hdf5-fortran-bindings=1 \
--download-metis \
--download-parmetis \
--download-yaml \
--download-zlib \
--download-fblaslapack \
--with-mkl_pardiso-dir=$MKLROOT \
--with-mkl_sparse-dir=$MKLROOT \
--with-mkl_sparse_optimize-dir=$MKLROOT \
--with-blaslapack-dir=$MKLROOT \
--with-debugging=0 \
COPTFLAGS="-O2 -mavx2 -axCORE-AVX512,CORE-AVX2,AVX" \
CXXOPTFLAGS="-O2 -mavx2 -axCORE-AVX512,CORE-AVX2,AVX" \
FOPTFLAGS="-O2 -mavx2 -axCORE-AVX512,CORE-AVX2,AVX" \
PETSC_ARCH=mkl-opt \
PETSC_DIR=$(pwd)

make PETSC_DIR=$(pwd) PETSC_ARCH=mkl-opt all
make PETSC_DIR=$(pwd) PETSC_ARCH=mkl-opt check
```
This should run successfully and install PETSc. 

## Install DAMASK

Again, we can use git to download DAMASK. Here, we install the `release` branch, but you can use any branch or tag that you prefer.
```
git clone https://github.com/damask-multiphysics/DAMASK.git

git checkout release
```
We will also use a submission script to make and install DAMASK, which we can call something like `install_damask.sh`.

```
#!/bin/bash --login

#$ -cwd
#$ -N install_damask

# Exports
export HDF5_USE_FILE_LOCKING=FALSE
export OMP_NUM_THREADS=1
export DAMASK_ROOT=$HOME/software/DAMASK

source $DAMASK_ROOT/env/DAMASK.sh
PATH=$PETSC_DIR/$PETSC_ARCH/bin:$PATH
LD_LIBRARY_PATH=$PETSC_DIR/$PETSC_ARCH/lib:$LD_LIBRARY_PATH

# contains:
module purge

module load mpi/intel-19.1/openmpi/4.1.1
module load tools/gcc/cmake/3.13.2

PETSC_DIR=$HOME/software/petsc
PETSC_ARCH=damask

cd $DAMASK_ROOT

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=../ -DDAMASK_SOLVER=GRID ../
make all install

```

This should make and install DAMASK fairly quickly. Now we can define another enviroment variable (add this to your bash profile as well). 

```
export DAMASK_grid=$HOME/software/DAMASK/bin/DAMASK_grid
```

DAMASK can now be run on the command line by simply executing `$DAMASK_grid`. You will also need to specifiy the various input files, however information about this can be found on the DAMASK website (https://damask-multiphysics.org/).