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

First of all, make sure your packages are up to date, with these two commands on the CSF:

```bash
module load apps/anaconda3/5.2.0/bin
pip install --user -U matflow damask-parse formable matflow-damask matflow-formable matflow-defdap matflow-mtex matflow-neper matflow-demo-extension
```

If you are having problems with loading your workflow locally (e.g. in a Jupyter notebook), make sure your local packages are up to date (run this on your computer):

```bash
pip install -U matflow damask-parse formable matflow-damask matflow-formable matflow-defdap matflow-mtex matflow-neper matflow-demo-extension
```

If you are still having problems, post a new GitHub issue in the installation repository ([UoM-CSF-Matflow](https://github.com/LightForm-group/UoM-CSF-matflow)), using the ["workflow problem" issue template](https://github.com/LightForm-group/UoM-CSF-matflow/issues/new/choose). If you are certain that a bug exists in one of the MatFlow extension packages, or [MatFlow](https://github.com/LightForm-group/matflow) or [HPCFlow](https://github.com/LightForm-group/hpcflow), then please create the GitHub issue in one of the respective repositories.

## Suggestions for new extensions/tasks/methods

Please add a new issue to the installation repository ([UoM-CSF-Matflow](https://github.com/LightForm-group/UoM-CSF-matflow))

## FAQs
**When I submit a workflow I get a message like "*The following schemas are invalid...*"; what does this mean?**

This indicates that some of the task schemas cannot be used, given the extension packages that you currently have installed. This is not a problem, unless you want to use one of those tasks. If you do try to use one of those tasks in a workflow profile, you will receive a more obvious error from MatFlow.
