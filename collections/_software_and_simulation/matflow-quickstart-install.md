---
title: Matflow - Quickest Quickstart in the West (QQTW)
author: Samuel Engel
tags:
  - CSF3
  - Matflow
  - Modelling
toc: false
published: true
subcollection: MatFlow
---

This page details how to install Matflow (https://docs.matflow.io) using centrally installed packages on the CSF3. 


## 1. Edit Bash Profile
Before we begin, it is important to add the following lines to you bash profile, this will allow you to use the modulefiles that are stored in the Clari/Lightform shared space on the CSF3.

```
cd

vim .bash_profile
```
With the editor open, add the following lines of code to the bottom

```
module use --append /mnt/eps01-rds/Fonseca-Lightform/shared/software/modulefiles
```

Make sure to save and exit, you will need to logout and log back in for the changes to take effect. 

## 2. Create your MatFlow Python Enviroment

Now we need to create a MatFlow enviroment, this can either be a python virtual enviromnent or a conda enviroment. In this example, we will use a conda enviroment. 

Firslty load a conda installation then create an enviroment called 'matflow-env' or something similiar. 

```
module load apps/binapps/anaconda3/2023.09

conda create -n matflow-env python=3.11

source activate matflow-env
```
Remember, never run the `conda init` command, no matter what Anaconda might tell or promise you. This will cause problems as it allows Anaconda to be always loaded in the background, even when you haven't directly loaded the module. 

Note that you will always need to load an Anaconda module and source the MatFlow enviroment whenever you login, alternatively you can add the first and last lines of the above block into your '.bash_profile' to automatically do this every time you log in. 

Now that our MatFlow enviroment is activated we can install the required packages.

```
pip install matflow-new==0.3.0a137
pip install hpcflow-new2==0.2.0a189
```
Ignore any warning it gives you. You can now run the 'matflow' command to check if things have installed correctly.

## 3. Create your MatFlow Config File

We now just need to add a 'config.yaml' file to tell MatFlow how to schedule jobs on the CSF3. 

Go to your home directory and create a folder called '.matflow-new', don't forget to add the full stop at the start. Then go into that directory and add create the configuration file. 

```
cd

mdkir .matflow-new
cd .matflow-new

vim config.yaml
```

You will want to add the following into this file once you have it open.

```
configs:
  CSF3:
    invocation:
      environment_setup:
      match:
        hostname: login*.pri.csf3.alces.network
    config:
      machine: CSF3
      telemetry: true
      log_file_path: logs/<<app_name>>_v<<app_version>>.log
      environment_sources:
        - /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs/matflow-damask-3.0.0alpha7/envs.yaml
      task_schema_sources: []
      command_file_sources: []
      parameter_sources: []
      default_scheduler: SGE
      default_shell: bash
      schedulers:
        direct:
          defaults: {}
        SGE:
          defaults:
            shebang_args: --login
          parallel_environments:
            null:
              num_cores: [1, 1, 1]
            amd.pe:
              num_cores: [2, 2, 64]
              num_nodes: [1, 1, 1]

      shells:
        bash:
          defaults: {}   
```

Now MatFlow should be fully installed and working. For now this just includes DAMASK, but further packages will be added in future.

## Building a Custom Install (Advanced Users)

The method above installs MatFlow using precreated conda enviroments that hold the relevant softwares, if you want different versions, or even additional softwares adding, you will need to create your own enviroments. 

In this example, we will use pip to install an experimental version of MatFlow that uses the release version of the crystal plasticity software DAMASK. You should repeat steps 1 and 2, but stop before you pip install anything. Instead navigate to the shared space on the CSF3.

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software
```
Each bit of software using by MatFlow is installed here, with different versions installed inside each folder, for example the `damask` folder contains versions `3.0.0` and `3.0.0alpha7` of DAMASK. This ensures we always have a static copy of the software available, as well as the most relevant versions needed. 

Go into the MatFlow folder and pip install it to your current MatFlow enviroment.

```
cd matflow/matflow-damask_beta_0/

pip install -e .

```
After that has installed, we also want to install a different version of HPCFlow.
```
pip install hpcflow-new2==0.2.0a189
```

Ignore any warning it gives you. Now navigate back to your home directory, we need to change the configuration file to use a different version of DAMASK.

```
cd

cd .matflow-new

vim config.yaml
```

Now change the configuration file to look like the following.

```
configs:
  CSF3:
    invocation:
      environment_setup:
      match:
        hostname: login*.pri.csf3.alces.network
    config:
      machine: CSF3
      telemetry: true
      log_file_path: logs/<<app_name>>_v<<app_version>>.log
      environment_sources:
        - /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs/matflow-damask-3.0.0/envs.yaml
      task_schema_sources: []
      command_file_sources: []
      parameter_sources: []
      default_scheduler: SGE
      default_shell: bash
      schedulers:
        direct:
          defaults: {}
        SGE:
          defaults:
            shebang_args: --login
          parallel_environments:
            null:
              num_cores: [1, 1, 1]
            amd.pe:
              num_cores: [2, 2, 64]
              num_nodes: [1, 1, 1]

      shells:
        bash:
          defaults: {}   
```

After that has done, you should be able to use the release version of DAMASK in MatFlow. You need to be careful as there have been some changes that will affect the demo workflows, which will cause them to no work correctly. This is usually because some parameters have become lists instead of single values and as such need some minor tweaking to the input file. 

