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

A jupyter notebook can be launched like so *(note the version number may change as python is updated)*;

```python
jupyter-notebook-icsf 3/2019.07
```

This allows you to interact and analyse data stored on your iCSF (incline) data storage space.

#### Launching the iCSF

The connection with the iCSF is created through a secure shell protocol like so **(note replace username with your actual username)**;

```python
ssh -X username@incline256.itservices.manchester.ac.uk
```

From here it is possible to view and search through your data storage space using *ls* (list), *cd* (change directory) commands. You can also *mv* (move) and *rm -rf* (delete) files, *mkdir* (make directory), and do pretty much whatever you like with the bash commands.

#### Connecting iCSF (incline) storage with RDS storage

To view files and interact with files on the Research Database Storage (RDS) space through the iCSF (incline) storage space, we need to setup a sym link. To setup a sym link to the personal RDS space we can use something like;

```python
ln -s /mnt/eps01-rds/Fonseca-Lightform/username ~/rds_lightform
```

And to link to the shared RDS space we can use;

```python
ln -s /mnt/eps01-rds/Fonseca-Lightform/shared ~/rds_lightform_shared
```

#### Loading modules

The most useful thing about the iCSF is the ability to launch interactive modules. The most useful modules for analysing synchrotron data are MATLAB, DAWN, DIOPTAS and MAUD;

```python
module load apps/binapps/matlab/R2019a
matlab
```

```python
module load apps/binapps/dawn/2.16.1
dawn
```

```python
source activate dioptas
dioptas
```

```python
module load apps/binapps/maud/2.93
maud.sh
```

### Interacting with the iCSF externally

It is also possible to interact with the iCSF and RDS space through an external terminal. From here it is possible to view the data stored on the RDS, and it is also possible to create port links to launch analyses and notebooks that run on the iCSF processors.

#### Viewing files on iCSF (incline) using OS X Fuse

To view files on your computer from the iCSF *(just like you would on an external hard drive)*, you can install the [OS X Fuse](https://osxfuse.github.io) package. Then, in the terminal you can create a directory within which you can view all of the folders and files on the iCSF *(including sym links to the RDS space)*;

```python
cd Desktop
mkdir iCSF-Home
sshfs -o follow_symlinks username@incline.itservices.manchester.ac.uk: iCSF-Home
```

In cases where this is not connected (usually due to the node being overloaded), you can instead use the slightly different command;

```python
sshfs -o follow_symlinks username@incline256.itservices.manchester.ac.uk: iCSF-Home
```

Sometimes, there can also be an issue with permissions to a shared folder, such as the sym link to the RDS shared folder, which shows up as permission denied. In this case, you can view the files in shared sym linked folders using;

```python
sshfs -o defer_permissions username@incline256.itservices.manchester.ac.uk:/mnt/eps01-rds/Fonseca-Lightform RDS
```

or;

```python
sshfs -o defer_permissions username@rds-ssh.itservices.manchester.ac.uk:/mnt/eps01-rds/Fonseca-Lightform RDS
```

#### Copying data to the iCSF (incline) 

