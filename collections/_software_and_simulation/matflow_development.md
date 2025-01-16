---
title: Developing Matflow
author: Guy Bowker, Gerard Capes
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

## A guide to developing your own tasks and schemas for matflow
Gerard's repository on this is an excellent place to start: https://github.com/LightForm-group/matflow-user-documentation

1. Configure matflow-new as in [instructions here](https://lightform-group.github.io/wiki/software_and_simulation/matflow-new-install) using [`requirements.txt`](https://github.com/LightForm-group/Do-more-with-less/blob/main/requirements.txt)
2. Navigate to a local dir where you have read/write access and git clone matflow-new into it: `git clone https://github.com/hpcflow/matflow-new.git .`
3. Install locally cloned `matflow-new` in egg mode using pip `pip install -e ./matflow-new` (egg mode means if you make changes then python will use the latest code you have written for this library)
4. Best practice is to first change branch to a new one describing your addition/change to the code. Do this off the develop branch as thats usually the furthest ahead.
5. Now you can make changes to code freely. Best practice is to test the code before committing.
6. When youve added your change and it works, commit your changes to code, push your branch to github and submit a pull request to merge your feature/change with develop branch of repo.
7. Request to owner of repo pull request into main if its a feature worth having in the software and its been thouroughly tested.
