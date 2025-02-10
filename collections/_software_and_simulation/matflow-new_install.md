[requirements.txt](https://github.com/user-attachments/files/18733542/requirements.txt)---
title: Installing Matflow
author: Guy Bowker, Gerard Capes, Samuel Engel
toc: true
tags:
  - python
  - matflow-new
  - csf
  - csf3
published: true
subcollection: MatFlow
---
# Matflow: An API for fully reproducible computational material science workflows
This page is intended to be the new place for all information on installing and reconfiguring matflow installations.
For instructions on how to write your own workflow, see [Gerards repository here](https://github.com/LightForm-group/matflow-user-documentation)

## Installing Python virtual environments

## Installing matflow-damask
Steps Ive done to install matflow-new with damask functionality on my CSF space:

Download this folder:
[matflow-new.zip](https://github.com/user-attachments/files/18733560/matflow-new.zip)

Create an environment of `python=3.10` using conda `conda create -n damask-venv python=3.10`

activate environment `conda activate damask-env`

install requirements `pip install -r requirements.txt`

Test matflow CLI works by just typing matflow in command line and pressing enter.

install `damask` and `damask-parse` `pip install damask==3.0.0a7.post0` `pip install damask-parse==0.2.30`  (NEED to be seperate commands because pip raises error if you try to do these together since 3.0.0a7.post0 isn’t considered >3.0.0 )!

Download config files `.matflow-new/` and put this dir in home (`~/`).

Ensure `.matflow-new/config.yaml` file l12 is `/mnt/iusers01/jf01/<username>/.matflow-new/envs_CSF3.yaml` replace `<username>` with yours (mine is y15576gb) ex. `/mnt/iusers01/jf01/y15576gb/.matflow-new/envs_CSF3.yaml`

Point all `setup:` variables in `.matflow-new/envs_CSF3.yaml` to your newly created environment. (For example see how `envs_CSF3.yaml` given here all have `conda activate damask-env` .

Navigate to scratch and test by running lightest demo workflow `matflow demo-workflow go tension_DAMASK_Al`.

ABOVE ALL CHECK `damask==3.0.0a7.post0` and `damask-parse==0.2.30` with `pip list` !!!

## Installing matflow-MTEX

## Workflow examples

## Development examples



## FAQ
### Q. Why is this page here?

**A**. Becuase Guy Bowker says so.
