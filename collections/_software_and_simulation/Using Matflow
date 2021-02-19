---
title: Using MatFlow
author: Guy Bowker
toc: true
tags:
  - python
  - matflow
  - workflow
  - yaml
  - yml
published: true
subcollection: MatFlow
---

## Running a workflow
Matflow workflows are in the form of .yaml or .yml text files. This file includes in list format the details of the individual tasks to perform in the order that they appear in the file. Below is an example of a workflow which undertakes the tasks described by the comments (following a hash #): Top tip - new to MAtflow? Try copying and pasting this into a text file named `uniaxial_tensile_test_sim.yaml` and using the command `matflow go uniaxial_tensile_test_sim.yaml` for yourself after installing matflow!

```
name: uniaxial_tensile_test_sim                      # name of the workflow
stats: false
# archive: dropbox                                   # copy results to a defined dropbox directory
run_options:                                         # options for running the entire workflow
  l: short                                           # max length of time for the workflow to run. (short means 1hr)

tasks:                                               # What follows is now the tasks to complete

  - name: generate_microstructure_seeds              # name of task 1
    method: random                                   # method of task, here we want to generate a random set of points in 3D space which will be the centres of grains.
    software: damask                                 # define the software to use for this task - here DAMASK.
    base:                                            # base variables defined for the task
      grid_size: [4, 4, 4]                           # here we define a cube of grid size 4x4x4. This means the elements in our simulation will total 4^3.
      num_grains: 3                                  # three grains within this cube
    output_map_options:                              # options for output
      phase_label: Al                                # arbitrary label of the phase wed like to simulate. (this is just a name - can be 'rubberducks' if you want)

  - name: generate_volume_element                    # name of task 2
    method: random_voronoi                           # here we'd like to generate a representative volume element (RVE)for our tensile test from the seeds we generated in task 1, using a voronoi tesselation to assign points closest to the seed points the same grain assigned at the seed points (grain 1, 2 etc.)
    software: damask
    base:
      size: [1, 1, 1]                                # This is the size of our RVE, and is different from grid size.
      homog_label: SX                                # label for homogenization when performing this task

  - name: visualise_volume_element                   # name of task 3 - here we want to convert the .geom file we made of our RVE into .vtr format - meaning we can view it in 3D using paraview later.
    method: VTK
    software: damask

  - name: generate_load_case                         # name of task 4 - uses formable, a python package to turn our defined loadcase into a format readable by damask.
    method: uniaxial                                 # specifying uniaxial, could also use planestrain or biaxial.
    software: formable
    base:
      total_times: [100]                             # total time in s to load for.
      num_increments: [200]                          # number of time increments the time to load for should be split into.
      target_strain_rates: [1.0e-3]                  # strain rate in /s youd like to load at. (+ve for tensile and -ve for compression)
      directions: [x]                                # direction of loading

  - name: simulate_volume_element_loading            # name of task 5 - the grand finale, simulating your RVE using the loadcase youve defined.
    method: CP_FFT                                   # stands for 'Crystal Plasticity_Fast Fourier Transform'
    software: DAMASK
    run_options:
      num_cores: 4                                   # defining we'd like to run this on 4 cores (for UoM-CSF users.)
      l: short                                       # max time for this task is 1hr.
    output_map_options:
      operations:                                    # post-processing options - this will output the defined results below
        - name: add_Cauchy                           # get cauchy stress for every element at every time increment
          args: {P: P, F: F}                         # results produced by the simulation required to calculate the cauchy stress.
          opts: {add_Mises: true}                    # ooh! While we're here, calculate the von-mises stress too!
        - name: add_strain_tensor                    # get strain tensor for every element at every time increment
          args: {F: F, t: V, m: 0}
          opts: {add_Mises: true}                    # aaaand while we're here, calculate the von-mises strain aswell!         
      incremental_data:                              # then defining where to actually get this data from the resultiant .hdf5 file this simulation produces.
        - name: vol_avg_equivalent_stress
          path: constituent/1_Al/generic/sigma_vM
          transforms: [mean_along_axes: 1]
        - name: vol_avg_equivalent_strain
          path: constituent/1_Al/generic/epsilon_V^0(F)_vM
          transforms: [mean_along_axes: 1]
        - name: vol_avg_equivalent_plastic_strain
          path: constituent/1_Al/generic/epsilon_V^0(Fp)_vM
          transforms: [mean_along_axes: 1]
          increments: 10                             # Extract data every 10th increment.
    base:
      homogenization_schemes:
        SX:
          mech:
            type: none
      phases:                                        # Phase parameters required for the simulation
        Al:
          elasticity:
            type: hooke
            C_11: 106.75e9
            C_12: 60.41e9
            C_44: 28.34e9            
          generic:
            output: [F, P, Fp]
          lattice: fcc
          plasticity:
            N_sl: [12]
            a_sl: 2.25
            atol_xi: 1.0
            dot_gamma_0_sl: 0.001
            h_0_sl_sl: 75e6
            h_sl_sl: [1, 1, 1.4, 1.4, 1.4, 1.4]
            n_sl: 20
            output: [xi_sl]
            xi_0_sl: [31e6]
            xi_inf_sl: [63e6]
            type: phenopowerlaw
```
