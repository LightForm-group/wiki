---
title: CIPHER (Calphad Integrated Phase-field solvER)
author: Sakina Rehman, Pratheek Shanthraj
tags:
  - simulation
  - csf
  - cipher
toc: true
published: true
---

CIPHER is a parallel phase-field simulation code for microstructure evolution in multi-component alloy systems. It includes advanced features such as automatic parallel adaptive mesh refinement, local truncation error estimates and adaptive time stepping. CIPHER is designed for a large number of phases (10-10000), with computational complexity independent of the number of phases, and uses an efficient grand-canonical-based phase-field implementation with direct use of Compound-Energy- Formalism and other CALPHAD thermodynamic models for multi-component systems [1].

## Installation
>This software requires MPI, p4est v2.2 [2], and PETSc v3.12 [3].

The following installation instructions are specific to users of the University of Manchester's Computational Shared Facility (CSF). Non CSF users will need to follow their local procedures to install, p4est and PETSc.

### To install p4est:

First load MPI compilers and OpenBLAS with the command:
```
module load mpi/intel-17.0/openmpi/3.1.3
module load libs/gcc/openblas/0.3.6
```
Navigate to a software folder or create it by entering:

```
mkdir $HOME/software
cd $HOME/software
```

Download p4est with the command line utility wget:
```
wget http://p4est.github.io/release/p4est-2.2.tar.gz
```

The p4est download will be compressed in a tar file. This can be extracted using:

```
tar -xvf p4est-2.2.tar.gz
```

The p4est tar file can now be deleted:

```
rm p4est-2.2.tar.gz
```
Those without the wget utility can download the latest p4est source from http://www.p4est.org and unpack. 

Navigate into the extracted p4est folder.  Now configure the p4est software library, with the correct command arguments (flags):
```
./configure --prefix=$PWD/intel-17.0-openblas --enable-mpi CC=mpicc FC=mpif90 F77=mpif77 CXX=mpic++ CFLAGS='-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2' CXXFLAGS='-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2' FFLAGS='-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2' BLAS_LIBS=$OPENBLASDIR/lib/libopenblas.a
```
This runs a script that will localize the source distribution so that it will compile and load on your local system.  Next enter:
```
make
make install
```
Now you need to add an environment variable to your system where p4est is located:
```
export P4EST_DIR=$HOME/software/p4est-2.2/intel-17.0-openblas
```
### To install PETSc:

Navigate back into the software folder and download PETSc with:

```
cd $HOME/software
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-3.12.1.tar.gz
```
Extract it with the tar utility:

```
tar -xvf petsc-lite-3.12.1.tar.gz
```

Set an environment variable to tell the system where PETSc is located:
```
export PETSC_DIR=$HOME/software/petsc-3.12.1
export PETSC_ARCH=intel-17.0-mkl
```
> Note that if you put PETSc in a different folder to that used in this example, you will need to alter this variable.

Make a folder, inside the PETSc folder and name if after the architecture that you will be using (e.g. mkdir intel-17.0-mkl).  Make another folder, inside the architecture folder for your external packages and name it ‘external packages’ (eg mkdir intel-17.0-mkl/externalpackages).  Add another line to .bash_profile to set an environment variable to specify what architecture PETSc will use:
```
mkdir $PETSC_DIR/$PETSC_ARCH/externalpackages
cd $PETSC_DIR/$PETSC_ARCH/externalpackages
```
Download three external packages for PETSc by navigating into the external packages folder.  The first of these is Triangle:
```
wget http://ftp.mcs.anl.gov/pub/petsc/externalpackages/Triangle.tar.gz
```
The next one is HDF5
```
wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.18/src/hdf5-1.8.18.tar.gz
```
The next one is YAML
```
wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
```
and finally Chaco:
```
wget  http://ftp.mcs.anl.gov/pub/petsc/externalpackages/Chaco-2.2-p2.tar.gz
```
Load cmake (required to install some external packages):
```
module load tools/gcc/cmake/3.11.4
```
Navigate to the folder containing PETSc and configure it, including the necessary flags:
```
cd $PETSC_DIR
./configure  --with-pthread --download-yaml=$PWD/$PETSC_ARCH/externalpackages/yaml-0.1.4.tar.gz --download-metis --download-parmetis --download-chaco=$PWD/$PETSC_ARCH/externalpackages/Chaco-2.2-p2.tar.gz --with-mkl_pardiso-dir=$MKLROOT --with-mkl_sparse-dir=$MKLROOT --with-mkl_sparse_optimize-dir=$MKLROOT --download-hypre --download-ml --download-triangle=$PWD/$PETSC_ARCH/externalpackages/Triangle.tar.gz --download-ctetgen --download-hdf5=$PWD/$PETSC_ARCH/externalpackages/hdf5-1.8.18.tar.gz --with-zlib --with-p4est-dir=$P4EST_DIR --with-blaslapack-dir=$MKLROOT --with-cxx-dialect=C++11 --with-debugging=0 COPTFLAGS="-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2" CXXOPTFLAGS="-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2" FOPTFLAGS="-O2 -msse4.2 -axSSE4.2,AVX,CORE-AVX2" PETSC_ARCH=$PETSC_ARCH PETSC_DIR=$PETSC_DIR
```
Then make PETSc:
```
make PETSC_DIR=$PETSC_DIR PETSC_ARCH=$PETSC_ARCH
make install PETSC_DIR=$PETSC_DIR PETSC_ARCH=$PETSC_ARCH all
```

### To install CIPHER:

If not already set, add CIPHER_DIR/bin to your PATH
```
export PATH=CIPHER_DIR/bin:$PATH
```
Navigate to examples folder
```
cd $CIPHER_DIR/examples/GrainBoundaryPrecipitate
```
And run an example:
```
mpiexec -n 4 cipher.exe --config GrainBoundaryPrecipitate.yaml
```

## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Dr. Pratheek Shanthraj at [pratheek.shanthraj@manchester.ac.uk](mailto:pratheek.shanthraj@manchester.ac.uk).

## References

[1] Grand-canonical phase-field implementation: [https://arxiv.org/abs/1906.10503](https://arxiv.org/abs/1906.10503)  
[2] p4est: [http://www.p4est.org](http://www.p4est.org/)  
[3] PETSc: [https://www.mcs.anl.gov/petsc/](https://www.mcs.anl.gov/petsc/)
