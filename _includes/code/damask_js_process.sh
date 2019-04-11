#!/bin/bash

#$ -S /bin/bash
#$ -N damask_process
#$ -cwd
#$ -V

# Move the large binary file onto scratch for processing:
mv ~/my_simulation/geom_load.spectralOut ~/scratch/my_simulation/

# Run post-processing steps:
postResults --cr "f,p" --co "totalshear" "geom_load.spectralOut"
addCauchy "postProc/geom_load.txt"
addStrainTensors --logarithmic --left "postProc/geom_load.txt"
addMises --stress "Cauchy" --strain "ln(V)" "postProc/geom_load.txt"