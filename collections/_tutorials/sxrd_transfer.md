---
title: Transferring data from Diamond or DESY beamlines
author: Christopher Daniel
subcollection: SXRD
---

## Transferring data from Diamond and DESY beamlines

It is important to try and transfer your data from Diamond or DESY beamlines as soon as possible, before it is transferred to tape (which can take time to restore). At Diamond, there is a **40 day limit** for storing data on their servers before it is moved to tape. At DESY, the data is kept for longer, but it still runs the risk the data could be lost.

### iCSF

You will first need to contact IT services to get setup with an iCSF account. The iCSF ([interactive Computational Shared Facility](http://ri.itservices.manchester.ac.uk/icsf/)) gives us access to the University's high performance computing environment. This allows us to store and analyse our large Synchrotron X-ray Diffraction (SXRD) datasets as a group.

### Accessing Research Database Storage (RDS) space

Our group has allocated funds to purchase space for research data storage (RDS) from the university, which is stored and backed up on the servers. You will need to contact IT services to be given a portion of this space, which you will have read/write access to, and others in the group will be able to read and download. You will also be given access to shared space, where everyone has read/write access. For instance;

`/mnt/eps01-rds/Fonseca-Lightform/username`

and 

`/mnt/eps01-rds/Fonseca-Lightform/shared`

To access this data on the iCSF you will first need to setup some symbolic links, which will enable you to view the folder. First, remote desktop into the interactive linux environment, launch the terminal, and log in to the iCSF using the command;

`ssh -X username@incline256.itservices.manchester.ac.uk`

Then, make a new directory in your home folder on the iCSF where you would like to store this data. For instance,

`mkdir rds_lightform`

Then, create the symbolic link;

`ln -s /mnt/eps01-rds/Fonseca-Lightform/mbcx9cd4 ~/rds_lightform`

In case there is a mistake in your filename you can delete a sym link using;

`unlink ~/rds_lightform`

### RDS-SSH service

It is not possible to transfer data within the Manchester's iCSF terminal or using Diamond's remote desktop, due to security issues.

So, you will then need to contact IT services to get setup with the RDS-SSH service. Your basic iCSF account will not allow you to transfer large amounts of data, which is why you will need the [RDS-SSH service](http://ri.itservices.manchester.ac.uk/rds/the-rds-ssh-service/). The basic commands for copying files using the RDS-SSH service are given here on this [webpage](http://ri.itservices.manchester.ac.uk/rds/user-faq/copying-files-between-cifs-and-nfs-shares/).

### Copying data from Diamond

Once you have the RDS space and the sym links to the folders setup AND you have been given access to the RDS-SSH service, you can begin the transfer.

Open a terminal on your mac or laptop. Connect to the SSH;

`ssh username@rds-ssh.itservices.manchester.ac.uk`

Change directory so you can view the folder you would like to transfer the data to. Then, run the following command, which will use rsync to transfer the data from the path on Diamond's servers to our RDS folder at Manchester. Note, this will not direct any data through your computer.

`rsync -azvn username@ssh.diamond.ac.uk:/dls/i12/data/2021/mg25682-2 diamond_data_rds`

The 'n' in the command after rsync is used as a test of the transfer. If it is working it will return a confirmation message such as;

`sent 110,286 bytes received 907,569 bytes 15,306.09 bytes/sec
total size is 87,034,154,221 speedup is 85,507.42 (DRY RUN)`

Then, you are ready to run the full transfer;

`rsync -azv username@ssh.diamond.ac.uk:/dls/i12/data/2021/mg25682-2 diamond_data_rds`

The final confirmation should return something like;

`sent 693,246 bytes  received 65,792,616,969 bytes  11,708,036.34 bytes/sec
total size is 87,034,154,221  speedup is 1.32`

### Copying data from DESY

For DESY the data transfer is slightly different.
