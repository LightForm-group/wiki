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

## Troubleshooting
**My workflow didn't run**

1. Type `matflow validate` into the terminal.
   - This ensures that matflow is installed correctly
   -  If your workflow does not work, go to 2.
2. Run the following in the terminal: `/mnt/eps01-rds/jf01-home01/shared/matflow/update_matflow.sh`. 
   - This ensures that you are using the latest stable version of matflow
   - If your worlflow does not work, go to 3
3. Check if there is an error with line numbers displayed in the CSF interface. 
   - If yes, that means that there is likely an error in the format of your YAML file, go to 4. 
   - If no, go to 5.
4. Check the yaml file on [https://yamlvalidator.com](https://yamlvalidator.com) . Make sure there are no indentation errors.
   - If your workflow still does not work, go to 5.
5. Look for `stderr.log` in the `simulate_volume_element` directory. 
   - If you've found it, go to 6. 
   - If there is no such directory, the workflow did not run at all, go to 7.
6. Read the error at the bottom of the log file. Comment out the relevant tasks, starting from the one at the bottom of the error message. This is to isolate the problem out.
   - If `stderr.log` is all 0s, then matflow go to 7.
   - If you have tried commenting out all of the tasks, go to 7.
   - If your workflow worked after commenting out tasks, go to 9.
7. Use one of the [example workflows](https://github.com/LightForm-group/UoM-CSF-matflow/tree/master/workflows).
   - If the example workflow is not working, repeat with a different example. 
   - If you have tried all of the examples go to 1 or contact a member of the team.
   - If the example workflow works go to 8.
8. Compare your workflow against the working example workflow at [https://text-compare.com](https://text-compare.com) and see what the differences are in the relevant task(s).
   - This is to isolate and fix the relevant task(s).
9. You have now identified the relevant task(s) that failed. Please refer to the corresponding troubleshooting section for that task.

**There's no visualisation of the results / There's no .vtr in the simulate_volume_element_loading task directory --WIP (more errors needed and more thorough solutions needed)**

1. Navigate to the `output` directory of your simulation (the directory address should look like this: `#/scratch/Your_Task_Name_and_Date/output`)
2. Read `t5_pro.o-------` (or `t4_pro.o-------` / `t6_pro.o-------` depending on how many tasks you have, it should be the final task)
3. Read the error message: 
  - If it is something like `Failed to execute the output map for output "volume_element_response". Exception was: Unable to allocate 72.0 MiB for an array with shape (1048576, 3, 3) and data type float64`, Go to 4
  - If it is something else (I have not encountered other errors yet, please provide additional errors)
4. Open your /yaml file and add the following lines into the `simulate_colume_element_loading` task: 
```sh
    run_options:
      num_cores: 8
      processing:
        l: mem256
```
and try again
5. If it still fails in the same way then replace the above with:
```sh
    run_options:
      num_cores: 16
      processing:
        l:mem512
```

Other tasks' troubleshooting WIP
