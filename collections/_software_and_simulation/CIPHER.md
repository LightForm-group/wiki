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

### Installing p4est:

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
### Installing PETSc:

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

### Installing CIPHER:

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
## Input .yaml file

> This example is used to briefly describe the purpose of each block contained within a CIPHER input .yaml file. The example used is from the shared GitHub micmog group for modelling grain boundary precipitation (GrainBoundaryPrecipitate.yaml). 

### header block

The first block is named the ```header``` block:

```
header:
  grid : [64, 64, 64]
  size : [64, 64, 64]
  n_phases : 3
  materials : [matrix, precipitate]
  interfaces : [grainboundary, pptboundary]
  components : [al, cu, mg, zn]
  outputs : [al_c, cu_c, mg_c, zn_c, phaseid] 
  ```

The ```grid``` section defines the grid size of the model and ```size``` defines the physical dimensions of the model. In this example, the model is 3-dimensional, however, the model can be defined as 2-dimensional or 1-dimensional by altering the dimensions in the [x, y, z] array. The ```n_phases``` section defines the number of phases used in the simulation and the ```material``` section defines the number of materials present in the model. The ```interfaces``` section defines the interfaces present in the model. For example, the ```pptboundary``` defines an interface at the precipitate boundary and ```grain boundary``` defines a grain boundary present. The ```components``` section can be used to define the components present in this model and the ```outputs``` are the results that will be written out to a ```.vtu``` file.

### solution_parameters block

Usually found below the header block is the ```solution_parameters``` block:
```
solution_parameters:
  time : 72000.0
  interfacewidth : 4
  initblocksize : [2, 2, 2]
  initrefine : 5
  maxnrefine : 5
  minnrefine : 3
  initcoarsen : 3
  amrinterval : 200 
  outputfreq : 5000
  outfile : GBP
  interpolation: cubic
  petscoptions : -ts_adapt_monitor
  ```
A detailed understanding of this block is perhaps not necessary when running simple simulations. The main sections include the ```time```, which is the physical time in seconds (note that the physical time is not the same as the simulation time), the ```outputfreq```, which is the number of steps after which the results will be written to a ```.vtu``` file, and the ```outfile``` which is the name of the output file.

### material block

In this example, there are two possible materials in the simulation: the matrix and the precipitate. The material block takes the usual structure of:

```
material:
  matrix:
    chemicalenergy : calphaddis
    molarvolume : 1e-5
    temperature0: 393.0
    chempot_ex_kineticcoeff : 1.0
    c0 : [0.90, 0.02, 0.04, 0.04]
    mobilityc :
      al :
        mobility0 : 1.0e+18
        unary_migration : 
          al : 
            t_coefficient : [-127200.0, -92.98]
            t_exponent: [0, 1]
          cu : 
            t_coefficient : [-181583.4, -99.8]
            t_exponent: [0, 1]
          mg : 
            t_coefficient : [-127200.0, -92.98]
            t_exponent: [0, 1]
          zn : 
            t_coefficient : [-83255.0, -92.92]
            t_exponent: [0, 1]
    unary_enthalpy : 
      al : 
        t_coefficient : [-7976.15, 137.093038, -1.884662e-3, -8.77664e-6, 74092.0]
        t_exponent: [0, 1, 2, 3, -1]
        tlnt_coefficient : -24.3671976
      cu : 
        t_coefficient : [-7770.458, 130.485235, -2.65684e-3, 1.29223e-6, 52478.0]
        t_exponent: [0, 1, 2, 3, -1]
        tlnt_coefficient : -24.112392
      mg : 
        t_coefficient : [-5767.34, 142.775547, 4.858e-3, -1.393669e-6, 78950.0]
        t_exponent: [0, 1, 2, 3, -1]
        tlnt_coefficient : -26.1849782
      zn : 
        t_coefficient : [-4315.967, 116.900389, -1.712034e-3, 1.264963e-6]
        t_exponent: [0, 1, 2, 3]
        tlnt_coefficient : -23.701314
```
This block defines the ```matrix``` material properties. The ```chemical energy``` section is used to define whether the material is disordered (```calphaddis```), a sub-lattice model (```calphad2sl```) etc. The ```temperature``` is also defined in this block. This temperature can be kept the same in each material for an isothermal simulation or can be set differently in each material to allow thermal diffusion to occur. The ```c0``` array defines the alloy compositions of the components present in the simulation. The sum of these compositions must be 1. This block also allows the addition of the atomic mobilities (```unary_migration```, ```binary_migration``` etc.) by inputting the temperature coefficients and temperature exponents. The enthalpy terms can also be added to this block (```unary_enthalpy```, ```binary_enthalpy```, ```ternary_enthalpy``` etc.) in the same manner. The atomic mobilities and energy parameters are obtained from a diffusion and thermodynamic database respectively. I basic understanding of the CALPHAD method is required to be able to input the correct parameters into this block [4]. 

## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Dr. Pratheek Shanthraj at [pratheek.shanthraj@manchester.ac.uk](mailto:pratheek.shanthraj@manchester.ac.uk).

## References

[1] Grand-canonical phase-field implementation: [https://arxiv.org/abs/1906.10503](https://arxiv.org/abs/1906.10503)  
[2] p4est: [http://www.p4est.org](http://www.p4est.org/)  
[3] PETSc: [https://www.mcs.anl.gov/petsc/](https://www.mcs.anl.gov/petsc/)
[4] Ursula R. Kattner and Carelyn E. Campbell. Invited review: modelling of thermodynamics and diffusion in multicomponent systems. Materials Science and Technology, 25(4):443–459, 2009.

