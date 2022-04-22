---
title: Transferring data from Diamond or DESY beamlines
author: Christopher Daniel
subcollection: SXRD
---

## Transferring data from Diamond and DESY beamlines

It is important to try and transfer your data from Diamond or DESY beamlines as soon as possible, before it is transferred to tape (which can take time to restore). At Diamond, there is a **40 day limit** for storing data on their servers before it is moved to tape. At DESY, the data is kept for longer, but it still runs the risk the data could be lost.

### iCSF

You will first need to contact IT services to get setup with an iCSF account. The iCSF ([interactive Computational Shared Facility](http://ri.itservices.manchester.ac.uk/icsf/)) gives us access to the University's high performance computing environment. IT can also give you access to the Research Database Storage (RDS) space, which is a safe, secure and backed up space to save all of our invaluable data. This allows us to store and analyse our large Synchrotron X-ray Diffraction (SXRD) datasets as a group.

### Accessing Research Database Storage (RDS) space

Our group has allocated funds to purchase space for research data storage (RDS) from the university, which is stored and backed up on the servers. You will need to contact IT services to be given a portion of this space, which you will have read/write access to, and others in the group will be able to read and download. You will also be given access to shared space, where everyone has read/write access. For instance;

`/mnt/eps01-rds/Fonseca-Lightform/username`

and 

`/mnt/eps01-rds/Fonseca-Lightform/shared`

To access this data on the iCSF you will first need to setup some symbolic links. A symbolic link, also known as a sym or a soft link is a special type of file that points to another file or directory (like a shortcut in Windows), this will allow you to view the contents of the folder. First, remote desktop into the interactive linux environment, launch the terminal, and log in to the iCSF using the command;

`ssh -X username@incline256.itservices.manchester.ac.uk`

Then, it is probably a good idea to make a new directory in your home folder on the iCSF where you would like to store this data. For instance,

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

Change directory so you can view the folder you would like to transfer the data to. 

Then, run the following command, which will use rsync to transfer the data from the path on Diamond's servers to our RDS folder at Manchester. Note, this will not direct any data through your computer.

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

First, using DESY's data management portal (Gamma Portal), you will need to register the FTP system. This is easily done by browsing the data on the portal and clicking a link for FTP registration. This will activate for 7 days. Here are the instructions for doing using the [Gamma Portal](https://confluence.desy.de/display/ASAP3/The+Gamma+Portal).

The FTP server provides access to the data using the FTP protocol. DESY has it's own instructions for doing this - [accessing beamtime data using FTP](https://confluence.desy.de/display/ASAP3/Accessing+beamtime+data+using+FTP).

However, we need to do run this FTP protocol on the **RDS-SSH service** at Manchester.

Open a terminal on your mac or laptop. Connect to the SSH;

`ssh username@rds-ssh.itservices.manchester.ac.uk`

Change directory so you are within the folder you would like to transfer the data to. 

Then, run the following series of commands to connect to the FTP server;

`mkdir -p ~/.lftp/certs`
`curl https://pki.pca.dfn.de/dfn-ca-global-g2/pub/cacert/chain.txt > ~/.lftp/certs/desy.pem`
`echo 'set ssl:ca-file ~/.lftp/certs/desy.pem' >> ~/.lftp/rc`
`echo 'debug 3' >> ~/.lftp/rc`
`lftp`
`open ftp://psftp.desy.de`
`user USERNAME`

Note the USERNAME should be your DESY (DOOR) username. You will then be prompted to enter your DESY (DOOR) password.

Now you are in your homepage for the for FTP server that you registered. Using the command `ls` you will see the list of folders. For example;

``` bash
---- Connecting to psftp.desy.de (2001:638:700:1004::1:37) port 21
**** connect(control_sock): Network is unreachable
---- Connecting to psftp.desy.de (131.169.4.55) port 21
<--- 220-***               
<--- 220-Welcome to psftp.desy.de
<--- 220-***
<--- 220 This is a private system - No anonymous login
<--- 230 OK. Current restricted directory is /
dr-xr-x---    6 26666      6666             4096 Feb  6 09:51 .
dr-xr-x---    6 26666      6666             4096 Feb  6 09:51 ..
-rw-r--r--    1 26666      6666              457 Mar 16 13:58 README.non-conformant-files.txt
-r--------    1 26666      6666             1581 Dec  6 17:05 beamtime-metadata-11010750.json
dr-xr-x---    2 26666      6666             4096 Dec  6 17:05 processed
dr-xr-x---    5 26666      6666             4096 Dec  7 22:10 raw
dr-xr-x---    2 26666      6666             4096 Dec  6 17:05 scratch_cc
dr-xr-x---    2 26666      6666             4096 Dec  6 17:05 shared
```

To copy the data run the mirror command. This will transfer the data from DESY's FTP server to the folder that you are working within on the RDS-SSH service.

`mirror raw`

After this data transferred you can run the next folder;

`mirror processing`

etc.

