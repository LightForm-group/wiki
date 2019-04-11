#!/bin/bash

#$ -S /bin/bash
#$ -N damask_run          # Name of the job
#$ -cwd                   # Submit in the current working directory
#$ -V                     # Export environment variables
#$ -pe smp.pe 4           # Use a parallel environment with four cores

mpirun -n $NSLOTS DAMASK_spectral -g <geom_file_name> -l <load_case_file_name>