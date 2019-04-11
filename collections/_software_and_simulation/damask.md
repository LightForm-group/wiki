---
title: DAMASK
author: Adam Plowman
tags:
  - simulation
  - csf
  - damask
toc: true
published: true
---

>Note: I am in the process of writing a Python package for simplifying the process of using DAMASK on the CSF. I will add a Wiki entry summarising this when it's done. -AP

[DAMASK](https://damask.mpie.de/) is a code for simulating crystal plasticity within a finite-strain continuum mechanical framework.

## Running DAMASK simulations on the CSF
* DAMASK is currently installed on the CSF (`csf3.itservices.manchester.ac.uk`) at Manchester.
* Due to a file-locking issue, DAMASK cannot currently be run on the `scratch` file system.
* Instead, we should run it within our group home directory `/mnt/iusers01/jf01/<user>` 
  * ...or maybe on RDS `/mnt/eps01-rds/jf01-home01/<user>`?
* The DAMASK binaries and processing scripts are loaded on the CSF via `module load apps/intel-15.0/damask/2.0.2`
* Assuming this module is loaded, a simple jobscript file to submit a simulation might look something like this:

```bash
{% include code/damask_js_basic.sh %}
```

>TODO: add a separate wiki entry for job array strategies


## Post-processing results on the CSF
* The large binary files produced by DAMASK need to be processed into a human-readable format using the `postResults` script included with DAMASK
* Since the DAMASK post-processing scripts are not parallelised, they should ideally be run in a separate, serial jobscript
* We need to be aware that storage is more limited on our `home` directory than on `scratch`
* One strategy is to move the large binary output file from `home` to `scratch` immediately after the simulation has completed, and then perform post-processing steps on `scratch`. Here is an example jobscript to do that:

```bash
{% include code/damask_js_process.sh %}
```

## Automating processing steps
* We could use job dependencies [[1]](#a1) to get the processing steps to start immediately after the simulation has finished
* Imagine we have our simulation directory set up within `home` like this:
```
my_simulation/
├── geom.geom
├── load.load
├── material.config
├── jobscript_run.sh
└── jobscript_process.sh
```
* i.e. we have our three simulation file inputs (geometry, load case and material specification) plus two jobscripts: one for running the simulation in parallel (`jobscript_run.sh`), and one for moving the binary output to scratch and subsequently running the post-processing steps in serial (`jobscript_process.sh`)
* We would first submit the simulation jobscript in the normal way:
  `qsub jobscript_run.sh`
* Doing so prints something like this: `Your job 129673 ("jobscript_run.sh") has been submitted`
* We can then submit the processing jobscript with the condition that it waits for the simulation jobscript before running. Using the simulation job ID, we can add a `hold_jid` argument to the processing jobscript submission like this:
  `qsub -hold_jid 129673 jobscript_process.sh`

### Bonus laziness
* If the above is too much effort, we could write a wrapper function around `qsub` to get the job ID of the main simulation jobscript and pass that directly to the submission of the processing jobscript.
[TODO]

## File downloads
[DAMASK simulation jobscript]({{ '/_includes/code/damask_js_basic.sh' | prepend: site.baseurl | prepend: site.url }})

[DAMASK processing jobscript]({{ '/_includes/code/damask_js_process.sh' | prepend: site.baseurl | prepend: site.url }})

## References
[<a name="a1">1</a>] [http://ri.itservices.manchester.ac.uk/csf/batch/job-dependencies/](http://ri.itservices.manchester.ac.uk/csf/batch/job-dependencies/)

*[CSF]: Computational Shared Facility
