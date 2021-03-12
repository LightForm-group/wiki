---
title: Visualising .vtr outputs using Paraview
author: Guy Bowker
tags:
  - post-processing
  - paraview
  - damask
toc: true
published: true
subcollection: DAMASK
---

# Paraview: how to visualise DAMASK results

Paraview is a data analysis visualisation software that produces 3d representations of `.vtk`, `.vtr` files. More information, as well as a link to download can be found [here](https://www.paraview.org), and a full tutorial on its use can be found [here](https://www.paraview.org/Wiki/images/b/bc/ParaViewTutorial56.pdf).

## Transferring the DAMASK output
After post-processing a damask `geom_load.hdf5` output using a `processing.py` script as shown [here](https://lightform-group.github.io/wiki/software_and_simulation/new-damask), outputs with the conventional name `geom_load_inc####.vtr` will be placed in the current working directory (cwd), or within a sub-directory named `postProc/`. To visualise these files, the user is advised to move these files to a directory on the users local machine. This may be done one of two ways; transfer of files via Dropbox, or using the `rsync` command on your local machine's terminal: 

```bash
rsync -avz username@csf3.itservices.manchester.ac.uk:~/myresult.dat .
```

Remember to change username to your University login username (eg. a#####bc) and `~/myresult.dat` to the filepath of the directory you would like to transfer. Ensure also to add a `.` to specify the location you'd like the files to be stored on your loacal machine as the cwd. This can be changed to a filepath also.
More info on how Rsync works as well as how to set up Dropbox for transferring files to and from the CSF can be found [here](http://ri.itservices.manchester.ac.uk/csf3/filesystems/file-transfer/).

## Using Paraview
### Opening `.vtk` `.vtr` files
Now that the `.vtk` or `.vtr` files are present on the local machine, start up paraview from the taskbar or .exe file. The desired files can be dragged into the left-hand 'Pipeline Browser' pane of the interface. When dragging multiple files in at once, paraview will group them together, with each one representing a time increment. This allows for some nice animations later. For now click 'apply' to apply changes.

[comment]: <> (image/gif of paraview)

### Applying filters to the data
From here the data can be manipulated in various ways, here is one example that is useful for damask output:

[comment]: <> (image/gif of selecting filters in paraview)

First select the dataset you'd like to filter. With this highlighted, from the 'Filters' dropdown on the top left menu, (on mac. May be different on windows) select the 'alphabetical' dropdown. From here scroll all the way down to 'Warp By Vector'. This will allow us to show the evolution of the volume change. (tension or compression) This will insert a new branch to the pipeline named `WarpByVector1`. Highlight this and click 'apply'. Now this is applied and highlighted, the dropdown on the center-top toolbar will contain the datasets defined in `processing.py`. Interacting with the 'play' buttons will now scrub through each time increment of the simulation, displaying the shape change during the test.
