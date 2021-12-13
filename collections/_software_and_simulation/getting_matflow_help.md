---
title: Getting help with MatFlow
author: Adam Plowman
toc: true
tags:
  - python
  - matflow
published: true
subcollection: MatFlow
---

## Getting help with MatFlow workflows

First of all, make sure your packages are up to date, with this command on the CSF:

```bash
/mnt/eps01-rds/jf01-home01/shared/matflow/update_matflow.sh
```

If you are having problems with loading your workflow locally (e.g. in a Jupyter notebook), make sure your local packages are up to date (run this on your computer):

```bash
pip install -U matflow damask-parse formable matflow-damask matflow-formable matflow-defdap matflow-mtex matflow-neper matflow-demo-extension
```

If you are still having problems, post a new GitHub issue in the installation repository ([UoM-CSF-Matflow](https://github.com/LightForm-group/UoM-CSF-matflow)), using the ["workflow problem" issue template](https://github.com/LightForm-group/UoM-CSF-matflow/issues/new/choose). If you are certain that a bug exists in one of the MatFlow extension packages, or [MatFlow](https://github.com/LightForm-group/matflow) or [HPCFlow](https://github.com/LightForm-group/hpcflow), then please create the GitHub issue in one of the respective repositories.

## Suggestions for new extensions/tasks/methods

Please add a new issue to the installation repository ([UoM-CSF-Matflow](https://github.com/LightForm-group/UoM-CSF-matflow))

## Importing large parameters

You may have issues when using `import` to re-use workflow parameters from an existing workflow, if the parameters are larger than the available memory on the login node at submission time. To prevent this, you can first submit, using `qsub`, a jobscipt that runs `matflow make`:

```sh
#!/bin/bash --login

#$ -cwd
#$ -N mf_make
#$ -pe smp.pe 6   # specify whatever resources are required to access sufficient memory

export HDF5_USE_FILE_LOCKING=FALSE
export OMP_NUM_THREADS=1

matflow make workflow_file.yml

```

Once this has run, a new workflow directory should be generated. You can then submit the workflow via this directory with `matflow go /path/to/workflow/directory`.

## FAQs
**When I submit a workflow I get a message like "*The following schemas are invalid...*"; what does this mean?**

This indicates that some of the task schemas cannot be used, given the extension packages that you currently have installed. This is not a problem, unless you want to use one of those tasks. If you do try to use one of those tasks in a workflow profile, you will receive a more obvious error from MatFlow.
