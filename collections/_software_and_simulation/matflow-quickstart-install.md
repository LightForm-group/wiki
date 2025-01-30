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

Now we need to create a MatFlow enviroment, this can either be a python virtual enviromnent or a conda enviroment. 

Firslty load a conda installation then create an enviroment called 'matflow-env' or something similiar. You can also create a local `envs` folder if you want to keep things neat and tidy. 

```
module load apps/binapps/anaconda3/2023.09

python -m venv matflow-env

source matflow-env/bin/activate
```
Remember, never run the `conda init` command, no matter what Anaconda might tell or promise you. This will cause problems as it allows Anaconda to be always loaded in the background, even when you haven't directly loaded the module. 

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

Now MatFlow should be fully installed and working.

## Building a Custom Install (Advanced Users)

The method above installs MatFlow using released versions of MatFlow, if you want to use a different version of MatFlow, that is perhaps on Github branch, you will need to use this example.  

In this example, we will use pip to install an experimental version of MatFlow that uses the release version of the crystal plasticity software DAMASK. You should repeat steps 1 and 2, but stop before you pip install anything. Instead navigate to the shared space on the CSF3.

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software
```
Each bit of software using by MatFlow is installed here, with different versions installed inside each folder, for example the `damask` folder contains versions `3.0.0` and `3.0.0alpha7` of DAMASK. This ensures we always have a static copy of the software available, as well as the most relevant versions needed. 

Go into the MatFlow folder and pip install it to your current MatFlow enviroment, which shouldn't include any version of MatFlow yet.

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

After that has done, you should be able to use the release version of DAMASK in MatFlow. You need to be careful as there have been some changes that will affect the demo workflows, which will cause them to not work correctly. This is usually because some parameters have become lists instead of single values and as such need some minor tweaking to the input file. 

## Creating your own Enviroments (Super-Advanced Users)

Currently, this process links to pre-existing enviroments on the CSF3. You might have a version of a software that is not currently supported and therefore need to make your own custom enviroment from scratch. In this example we will look at how to create a custom DAMASK enviroment, and the best practice for installing it centrally for everyone to use. If you are shy about sharing your MatFlow enviroment or uncomfortable installing in a shared space, then you can simply create these files in your home directory, ideally in a folder called `software`, `envs` or something similiar.

Now navigate to the `envs` folder on the shared space. This is located at `/mnt/eps01-rds/Fonseca-Lightform/shared/software/envs` if you get lost. You will need to create an aptly named folder to hold your custom MatFlow installation, for example we will call this folder `matflow-damask-3.0.0temperature`. For further clarity, add a `README` in this folder to describe the specific versions of each software you are installing. 

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs

mkdir matflow-damask-3.0.0temperature

cd matflow-damask-3.0.0temperature
```

Now that you are in this folder you should create a local conda enviroment.

```
python -m venv matflow-damask-env
```
Make sure to call the enviroment `matflow-damask-env` to avoid any confusion about the enviroments purpose. The README and enclosing folder name should give enough information to discern the enviroments purpose. Now activate the enviroment.

```
source matflow-damask-env/bin/activate
```
Now that we have a conda enviroment, we need to install MatFlow, DAMASK and DAMASK-parse. For DAMASK 3.0.0 we will need to use the `matflow-damask_beta_0` installation in the `matflow` folder. 

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/matflow/matflow-damask_beta_0

pip install -e .
```

Now we can install DAMASK-parse.

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/damask-parse/damask-parse-damask_beta0_with_T

pip install -e .
```

And finally, we install DAMASK python. Note that we need to go to the `python` folder within the enclosing folder. 

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/damask/DAMASK-3.0.0-beta/python

pip install -e .
```
You will now have a custom MatFlow-DAMASK enviroment that is ready to go. Deactivate the enviroment and go to your home directory. You will need to create a `matflow-env` that uses the same version of MatFlow that we have installed above, following the same method in Step 2, but making sure to use `pip install -e .` method we have used here. 

```
cd

python -m venv matflow-env

source matflow-env/bin/activate

cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/matflow/matflow-damask_beta_0

pip install -e .

pip install hpcflow-new2==0.2.0a189
```

Now that we have this set up, we just need to tell our `config.yaml` where our custom installation is. Open the config file and change the enviroment sources to point to the folder we have created. You will notice that this points to a `envs.yaml` file, which we will create next.

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
        - /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs/matflow-damask-3.0.0temperature/envs.yaml
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

Now go back to the `envs` folder that we have created. 

```
cd /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs/matflow-damask-3.0.0temperature
```
Now lets create the `envs.yaml` file. 

```
- name: damask_parse_env
  setup: |
    module load apps/binapps/anaconda3/2023.09
    source /mnt/eps01-rds/Fonseca-Lightform/shared/software/envs/matflow-damask-3.0.0temperature/matflow-damask-env/bin/activate
  executables:
    - label: python_script
      instances:
        - command: python <<script_name>> <<args>>
          num_cores:
            start: 1
            stop: 32
          parallel_mode: null

- name: damask_env
  setup: |
    module load damask/3.0.0-beta
  executables:
    - label: damask_grid
      instances:
        - command: $DAMASK_grid
          num_cores: 1
          parallel_mode: null

        - command: mpirun -n $NSLOTS $DAMASK_grid
          num_cores:
            start: 2
            stop: 32
          parallel_mode: null

- name: python_env
  setup: |
    module load apps/binapps/anaconda3/2023.09
  executables:
    - label: python_script
      instances:
        - command: python <<script_name>> <<args>>
          num_cores:
            start: 1
            stop: 32
          parallel_mode: null
```

You can add extra sections for other softwares, but the default values from other installations should be fine to use and therefore we won't discuss them here.

Now we are all done and you should have a working custom MatFlow. 
