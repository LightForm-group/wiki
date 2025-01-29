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


## Edit Bash Profile
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

## Create your MatFlow Python Enviroment

Now we need to create a MatFlow enviroment, this can either be a python virtual enviromnent or a conda enviroment. In this example, we will use a conda enviroment. 

Firslty load a conda installation then create an enviroment called 'matflow-env' or something similiar. 

```
module load apps/binapps/anaconda3/2023.09

conda create -n matflow-env python=3.11

source activate matflow-env
```

Note that you will always need to load Anaconda and then source the MatFlow enviroment whenever you login, alternatively you can add the first and last lines of the above block into your '.bash_profile' to automatically do this every time you log in. 

Now that our MatFlow enviroment is activated we can install the required packages.

```
pip install matflow-new==0.3.0a137
pip install hpcflow-new2==0.2.0a189
```
You can now run the 'matflow' command to check if things have installed correctly. We now just need to add a 'config.yaml' file to tell MatFlow how to schedule jobs on the CSF3. 

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
