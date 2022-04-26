---
title: Synchrotron X-ray diffraction analysis on iCSF / CSF
author: Christopher Daniel
subcollection: SXRD
---

## Synchrotron X-ray diffraction analysis on iCSF / CSF

### iCSF

You will first need to contact IT services to get setup with an iCSF account. The iCSF (interactive Computational Shared Facility) gives us access to the University’s high performance computing environment. IT can also give you access to the Research Database Storage (RDS) space, which is a safe, secure and backed up space to save all of our invaluable data. This allows us to store and analyse our large Synchrotron X-ray Diffraction (SXRD) datasets as a group and to keep it all in one place.

### Interacting with the iCSF using remote desktop

The iCSF is usually accessed via a remote desktop client. You will first need to download the [X2Go Client](https://wiki.x2go.org/doku.php/download:start). Within X2Go you can setup a host to the nyx connection nodes and set the session preferences like this;

*Host: incline.itservices.manchester.ac.uk
User Name: (your university username e.g. mbcx9cd4)
Password: (your university password)
Port: 22
Tick ‘Follow Symbolic Links’, ‘Auto Cache’ and ‘Defer Permissions’
Mount Point: (where you want to view the virtual desktop files i.e. /Users/(mac user name)/iCSF-Home)
Volume Name: iCSF-Home
Tick ‘Show in Finder Sidebar’
[TODO] - Check session preferences.*

Once this is setup you can connect to the remote desktop linux environment, from which you can launch connections with the iCSF. To connect with the iCSF you will need to open the terminal and use linux bash commands.

### Basic commands

#### Launching a basic Jupyter Notebook

A jupyter notebook can be launched like so *(note the version number may change as python is updated)*;

```bash
jupyter-notebook-icsf 3/2019.07
```

This allows you to interact and analyse data stored on your iCSF (incline) data storage space.

#### Launching the iCSF

The connection with the iCSF is created through a secure shell protocol like so **(note replace username with your actual username)**;

```bash
ssh -X username@incline256.itservices.manchester.ac.uk
```

From here it is possible to view and search through your data storage space using *ls* (list), *cd* (change directory) commands. You can also *mv* (move) and *rm -rf* (delete) files, *mkdir* (make directory), and do pretty much whatever you like with the bash commands.

#### Connecting iCSF (incline) storage with RDS storage

Our group has allocated funds to purchase space for research data storage (RDS) from the university, which is stored and backed up on the servers. You will need to contact IT services to be given a portion of this space, which you will have read/write access to, and others in the group will be able to read and download. You will also be given access to shared space, where everyone has read/write access. For instance;

`/mnt/eps01-rds/Fonseca-Lightform/username`

and 

`/mnt/eps01-rds/Fonseca-Lightform/shared`

To access the RDS data on the iCSF (incline) storage space you will first need to setup some symbolic links. A symbolic link, also known as a sym or a soft link is a special type of file that points to another file or directory (like a shortcut in Windows), this will allow you to view the contents of the folder. First, remote desktop into the interactive linux environment, launch the terminal, and log in to the iCSF using the command;

```bash
ssh -X username@incline256.itservices.manchester.ac.uk
```

Then, it is probably a good idea to make a new directory in your home folder on the iCSF where you would like to store this data. For instance,

```bash
mkdir rds_lightform
```

Then, create the symbolic link;

```bash
ln -s /mnt/eps01-rds/Fonseca-Lightform/mbcx9cd4 ~/rds_lightform
```

In case there is a mistake in your filename you can delete a sym link using;

```bash
unlink ~/rds_lightform
```

#### Loading modules

The most useful thing about the iCSF is the ability to launch interactive modules. The most useful modules for analysing synchrotron data are MATLAB, DAWN, DIOPTAS and MAUD;

```bash
module load apps/binapps/matlab/R2019a
matlab
```

```bash
module load apps/binapps/dawn/2.16.1
dawn
```

```bash
source activate dioptas
dioptas
```

```bash
module load apps/binapps/maud/2.93
maud.sh
```

#### Memory Check

If you are experiencing memory issues on the iCSF at any time, you can check the memeory usage of the home partition (space shared by all users):

```bash
df -h /home
```

Or you can also check how much space your home directory is using;

```bash
du -skh $HOME
```

### Interacting with the iCSF externally

It is also possible to interact with the iCSF and RDS space through an external terminal. From here it is possible to view the data stored on the RDS, and it is also possible to create port links to launch analyses and notebooks that run on the iCSF processors. To view your iCSF (incline) storage space you can use the secure shell protocol like so;

```bash
ssh -t -L 7779:localhost:7779 mbcx9cd4@incline256.itservices.manchester.ac.uk
```

From here, **and on your own terminal** it is possible to view and search through your data storage space using *ls* (list), *cd* (change directory) commands. You can also *mv* (move) and *rm -rf* (delete) files, *mkdir* (make directory), and do pretty much whatever you like with the bash commands.

#### Viewing files on iCSF (incline) using OS X Fuse

To view files on your computer from the iCSF **(just like you would on an external hard drive)**, you can install the [OS X Fuse](https://osxfuse.github.io) package. Then, in the terminal you can create a directory within which you can view all of the folders and files on the iCSF *(including sym links to the RDS space)*;

```bash
cd Desktop
mkdir iCSF-Home
sshfs -o follow_symlinks username@incline.itservices.manchester.ac.uk: iCSF-Home
```

In cases where this is not connected (usually due to the node being overloaded), you can instead use the slightly different command;

```bash
sshfs -o follow_symlinks username@incline256.itservices.manchester.ac.uk: iCSF-Home
```

Sometimes, there can also be an issue with permissions to a shared folder, such as the sym link to the RDS shared folder, which shows up as permission denied. In this case, you can view the files in shared sym linked folders using;

```bash
sshfs -o defer_permissions username@incline256.itservices.manchester.ac.uk:/mnt/eps01-rds/Fonseca-Lightform RDS
```

or;

```bash
sshfs -o defer_permissions username@rds-ssh.itservices.manchester.ac.uk:/mnt/eps01-rds/Fonseca-Lightform RDS
```

To close the directory you used to be able to use;

```bash
umount -f /Users/mbcx9cd4/Desktop/iCSF-Home
```

However, this seems to cause problems with the latest Mac OS, so better now to use;

```bash
diskutil unmount /Users/mbcx9cd4/Desktop/iCSF-Home
```

#### Copying data to the iCSF (incline) 

For copying bulk experimental data from synchrotron beamlines such as Diamond or DESY, please see the tutorial `Transferring data from Diamond or DESY beamlines` found under the `SXRD running experiment` tab on the LightForm Wiki.

For general copying of data to and from the iCSF (incline) and RDS space, you can use the `cp` command *(for copying everything without comparison)*, or the `rsync` command *(for only copying changes ot the source data)*;

```bash
cp -vr source destination
```

```bash
rsync -azv source destination
```

*Note leading ~/ in path means your home folder, leading ./ means in this folder or stuff in current working directory.*

So, in this example the command is used to transfer data from a data refinement (TOPAS) from a personal computer onto the RDS space, which is sym linked to the iCSF (incline) storage space.

```bash
rsync -azv ~/Documents/Dropbox\ \(The\ University\ of\ Manchester\)/Zr\ Computer/TOPAS/Data\ Transfer/Batch05/ username@incline256.itservices.manchester.ac.uk:rds_lightform/SXRD_analysis/desy_2021/experiment05-deformation/phase-fraction-TOPAS/Batch05
```

It would also be valid to use `username@rds-ssh.itservices.manchester.ac.uk:` instead of `username@incline256.itservices.manchester.ac.uk:`, to transfer the data to the RDS space directly.

#### Setting up virtual environment for Jupyter Notebook

To ensure that your packages do not mix up and interfere with each other during your analysis it is important to setup a virtual python environment, and to work within that python environment. A virtual environment can be setup like so using a list of the required packages *(found in requirements.txt)*;

```bash
cd python_package/
python -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install jupyter
pip install -r requirements.txt
```

From here, you could launch python (`python`) or launch a notebook (`python -m jupyter notebook`) within the virtual environment. **However, the notebook will not launch in the browser unless you are able to launch it via a port link (see below on how to set this up).**

You can check what versions are downloaded using;

```bash
pip list
```

And if it's necessary to force upgrade some packages then you can use;

```bash
pip install --upgrade -r requirements.txt
pip install --upgrade specific_python_package
```

Note in some instances, for developers, you may want to run in egg mode, to update packages instantly, for example using;

```bash
pip install -e .
```

#### Launching Jupyter Notebook via port link

First you need to create a shell script for launching the port link;

```bash
vi start-notebook.sh
chmod 744 start-notebook.sh
```

Then, after having setting up a virtual environment and closed it, you can launch a notebook via a port link in the terminal, like so;

```bash
ssh -t -L 7780:localhost:7780 username@incline256.itservices.manchester.ac.uk "virtualenv-setup/start-notebook.sh 7780 . rds_lightform/SXRD_analysis_packages/pyFAI-integration-caking/venv && exit"
```

This will create a link to launch the notebook, which you can open on your own computer, but will run all processes via the iCSF, saving your own computer processing power. This notebook does not become slow and laggy, like the one on the iCSF, and is therefore very useful for editing notebooks.

You can also use this same command to launch the notebook on the linux remote desktop, which is useful for when you are not editing the notebook, but want to analyse larger datasets using the iCSF.

#### ADVANCED - Altering the bashrc file

At some points you may need to alter the bashrc file, this is done by opening the file in a text editor;

```bash
nano ~/.Basic
vi ~/.bashrc
echo $PATH
```
