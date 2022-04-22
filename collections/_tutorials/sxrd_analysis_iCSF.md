---
title: Synchrotron X-ray diffraction analysis on iCSF / CSF
author: Christopher Daniel
subcollection: SXRD
---

## Synchrotron X-ray diffraction analysis on iCSF / CSF

### iCSF

You will first need to contact IT services to get setup with an iCSF account. The iCSF (interactive Computational Shared Facility) gives us access to the University’s high performance computing environment. IT can also give you access to the Research Database Storage (RDS) space, which is a safe, secure and backed up space to save all of our invaluable data. This allows us to store and analyse our large Synchrotron X-ray Diffraction (SXRD) datasets as a group and to keep it all in one place.

### Interacting with the iCSF using remote desktop

The iCSF is usually accessed via a remote desktop client. You will first need to download the [X2Go Client](https://wiki.x2go.org/doku.php/download:start). Within X2Go you can setup a host to the nyx connection nodes.

[TODO] - Update with session preferences.

Once this is setup you can connect to the remote desktop linux environment, from which you can launch connections with the iCSF. To connect with the iCSF you will need to open the terminal and use linux bash commands.

### Basic commands

#### Launching a basic Jupyter Notebook

A jupyter notebook can be launched like so *(note the version number may change as this python is updated)*;

```python
jupyter-notebook-icsf 3/2019.07
```

This allows you to interact and analyse data stored on your data storage space.

#### Launching the iCSF

The connection with the iCSF is created through a secure shell protocol like so *(note replace username with your actual username)*;

```python
ssh -X username@incline256.itservices.manchester.ac.uk
```

From here it is possible to view and search through your data storage space using *ls* (list), *cd* (change directory) commands. You can also *mv* (move) and *rm -rf* (delete) files, and do pretty much whatever you like with the bash commands.

#### Loading modules



### Interacting with the iCSF externally

It is also possible to interact with the iCSF and RDS space through an external terminal. Form this it is possible to view the data stored on the RDS, and it is also possible to create port links to launch analyses and notebooks that run on the iCSF processors.
