---
title: Accessing Jupyter notebooks on the UoM iCSF (interactive Computational Shared Facility)
author: Rhys Thomas
tags:
  - python
  - CSF
  - jupyter
published: true
subcollection: Python
---

If you are planning on analysing large datasets using DefDAP (or any external Python package in fact), you may consider using the [University’s iCSF service](http://ri.itservices.manchester.ac.uk/icsf/). As of Aug 2020, each node has 2 x 14-core Intel Broadwell CPU with 256 GB RAM. This is significantly more powerful than an university provided laptop and has more RAM than the Linux/Windows workstations at the office. The following instructions are a simple guide on how to use Jupyter Notebook via x2go on the iCSF, including how to install additional Python packages and access your files. These instructions are based on various IT Services guides, which are linked below.

Note: You can also run Jupyter Notebook on the CSF (Computational Shared Facility) if you require more computational power and RAM, but this system is more complex to set up and you may need to wait for access. For the purposes of what we want to achieve, running on the iCSF is sufficient (for now anyway). Details of how to run Jupyter Notebook on the CSF are [here](http://ri.itservices.manchester.ac.uk/csf3/software/applications/jupyter-notebook/).

## Running Jupyter Notebook on the iCSF via x2go

1. First contact the IT Services RI team: its-ri-team@manchester.ac.uk to setup a iCSF\x2go user profile and provide the following details (as per [this guide by IT Services](http://ri.itservices.manchester.ac.uk/icsf/getting-started-on-icsf/user-accounts/)):
    - the name of the system you wish to access – in this case the iCSF and Virutal Desktop Service (x2go)
    - a brief description of why you want to use the iCSF - in this case using Jupyter Notebook on the iCSF via x2go
    - your University IT Username (not password)
    - your library card number
    - the name of your PI/supervisor/line manager

#### Before continuing, make sure you are connected to the VPN

2. Follow the x2go setup guides here: for [Windows](http://ri.itservices.manchester.ac.uk/virtual-desktop-service/x2go/windows/) \ [MacOS](http://ri.itservices.manchester.ac.uk/virtual-desktop-service/x2go/mac/) \ [Linux](http://ri.itservices.manchester.ac.uk/virtual-desktop-service/x2go/linux/). This will hopefully give you access to a Linux virtual machine like this:
![](https://www.dropbox.com/s/26e94pp5cc2pdim/x2go.jpg?raw=1)

#### Note: Avoid running computationally expensive software directly on this virtual machine, it is used in this case as a means to access the iCSF (aka Incline).

4. Open the Terminal from the Applications menu bar in the top left (Applications > System Tools > MATE Terminal). Note: I would recommend adding a shortcut to the Terminal to the desktop (right click the shortcut in the menu bar and click ’Add this launcher to desktop).
5. Run `jupyter-notebook-icsf 3/2019.07` and enter your password when prompted. You will be provided with an URL in the terminal , with a similar format to:
`http://localhost:7777/?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
Right-click on this link in the terminal window and select ‘Open Link’.

## To install additional packages i.e. DefDAP:

1. First, open another Terminal window and write `ssh incline256`. Type your password to login.
2. Run the following two commands so that the internet is accessible:
`export http_proxy=http://webproxy.its.manchester.ac.uk:3128`
`export https_proxy=http://webproxy.its.manchester.ac.uk:3128`
3. Run the following command to load anaconda: `module load apps/binapps/anaconda3/2019.07`
4. Run the following command to install DefDAP: `pip install --user defdap`. You can install any package from [Python Package Index (PyPI)](pypi.org) by changing the final argument.
5. You can then quit this terminal and go back to your browser window.
6. You will need to restart the Python kernel to use the new package (Kernel > Restart)
![](https://www.dropbox.com/s/rsrn1tsxh5elr43/restart.jpg?raw=1)
7. Check you can import the package by typing `import defdap` into a cell and running the cell. If you don’t get any errors then it’s worked.

## Accessing your files
When you register to use iCSF, you will be provided with storage on the university servers. This is what you will see when you first open Jupyter Notebook (hence why it will be empty apart from a Scratch folder). Instructions for accessing this storage on your local PC are given [here](http://ri.itservices.manchester.ac.uk/userdocs/file-transfer/). Make sure you use `incline.itservices.manchester.ac.uk` as the hostname.
To access my files, I personally use a program called [CyberDuck](https://cyberduck.io) which works well (on Windows and Mac) and it very easy to set up. The settings are shown below (replace username and password with your own of course):

![](https://www.dropbox.com/s/syfn5n8osa4o5cm/cyberduck.png?raw=1)

You will then be shown a list of your files, where you can drag and drop between the university storage and your local PC.
