---
title: Input File
author: Sakina Rehman, Pratheek Shanthraj
tags:
  - simulation
  - csf
  - cipher
toc: true
subcollection: CIPHER (Calphad Integrated Phase-field solvER)
published: true
---
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

### interface block

The interface block usually takes the structure of:
```
interface :
  grainboundary :
    energy : 
      e0: 5.0e+8
    mobility : 
      m0: 2.0e+2
      activation_energy:
        t_coefficient : -1.0e+5
        t_exponent: 0
    potential : [0.175e+4, -0.180e+4, -0.235e+4]  
```

The interface type mentioned here is the ```grain boundary```. Here the ```energy``` and ```mobility``` terms are inputted, which should be normalised to the appropriate length scale. Further interface types can be added e.g. ```pptboundary`` with the same block structure.
### boundary block

To allow either a chemical or thermal influx into the simulation, a boundary block must be included:

```
boundary: 
  influx: 
    boundary_id: 3
    chem:
      type: neumann
      value: [0.0, 0.0, 1e7]
 ```
 
This ```boundary_id``` defines the boundary at which the influx will be applied and ```type``` defines the type of boundary condition, which, in this case, it is set as the Neumann or second-type boundary condition. In the ```value``` section the value of the influx at the boundary condition can be added e.g. an oxygen influx in partial pressure units. Please note that the ```boundary``` section must be added to the ```header``` block in order for the boundary condition to be applied:

```
boundaries : influx
```
### mappings block

Each of the phases present must be assigned a material type, this is where the ```mapping``` block comes into use:

```
mappings:
  phase_material_mapping : |-
    2 of 1
    2
  voxel_phase_mapping: |-
    116510 of 1
    4 of 3
    59 of 1
    6 of 3
    57 of 1
    ...
    interface_mapping: |-
    2 of 1
    7 of 2
```
For the GrainBoundaryPrecipitate.yaml example, in the ```phase_material_mapping```, '2 of 1' indicates 1 being repeated twice, so phase 1 is material 1 and phase 2 is material 1. The second line '2' shows that phase 3 is material 2. If there was '2 to 1' written in this block, this would create a list i.e. 2, 1. For example, if '10 to 5' was written, this would list 10, 9, 8, 7, 6, 5. If there is an $n$ number of phases, then there is an $n^2$ number of interfaces between $n$ phases. As this example has 3 phases, there are 9 possible boundaries. This is why there are 9 interfaces mapped under ```interface_mapping```

In terms of mapping, it is ideal to orientate a model so it is easier to assign phases i.e. compact models. For the more complex geometries there are automatic scripts to generate them.

## Contact

This code is maintained by the Microstructure Modelling Group at the University of Manchester. For questions, comments, bug-reports or contributions please email Dr. Pratheek Shanthraj at [pratheek.shanthraj@manchester.ac.uk](mailto:pratheek.shanthraj@manchester.ac.uk) or Sakina Rehman at [sakina.rehman@postgrad.manchester.ac.uk](mailto:sakina.rehman@postgrad.manchester.ac.uk).

## References

[1] Grand-canonical phase-field implementation: [https://arxiv.org/abs/1906.10503](https://arxiv.org/abs/1906.10503)  
[2] p4est: [http://www.p4est.org](http://www.p4est.org/)  
[3] PETSc: [https://www.mcs.anl.gov/petsc/](https://www.mcs.anl.gov/petsc/)
<br />[4] Ursula R. Kattner and Carelyn E. Campbell. Invited review: modelling of thermodynamics and diffusion in multicomponent systems. Materials Science and Technology, 25(4):443–459, 2009. <br />
[5] The Paraview Guide: [https://www.paraview.org/paraview-guide/](https://www.paraview.org/paraview-guide/)
