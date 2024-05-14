---
title: Thermodynamic Software
author: Joe Robson
toc: true
---

## Thermodynamic Modelling Software at Manchester

The following thermodynamic software packages are available within the CLARI group.
JMatPro – phase equilibria and solidification modelling (+physical property prediction) 
ThermoCalc – phase diagrams and thermodynamics 
This software is installed on the modelling PC. Please contact the #jmatpro_users or #mortonpc group on Slack if you have problems accessing this machine. Ask you supervisor to add you to Slack if you are not a member already. To use this software from elsewhere, you need to remote log-in or install on your own machine (JMatPro only).

## JMatPro

The current version of JMatPro can either be run using remote desktop (see later) or by installing on your own computer. Installing on your computer is preferred as multiple users are allowed. Up to 5 users can use JMatPro simultaneously. For it to work, the USB key must be inserted in the modelling PC in Royce (if you get a licence error, post a message on Slack jmatpro channel).

## Multiuser Method: 

To install JMatPro on your own machine (Windows only), first download it at: <https://www.sentesoftware.co.uk>
You will need the **login details** - please see pinned post on the **#jmatpro_users** Slack group (ask your supervisor to add you to the Slack group #jmatpro_users if you are not a member). 

You can then download and install the latest version (you want the standard version, not the node-locked version). Providing you are on a Materials based PC or VPN, the USB key should be found when you run JMatPro. There is a small possibility that your computer cannot find the licence on the network. In this case, if you get a licence error, try the following procedure:

```
1. Open a web browser and follow the link <http://localhost:1947/_int_/config_to.html> 
2. Make sure the option "Allow Access to Remote Licenses" is checked (if not, check it)
3. Uncheck the option "Broadcast Search for Remote Licenses", and check the option "Aggressive Search for Remote Licenses"
4. Under "Specify Search Parameters", enter the IP address of the license server, i.e. 130.88.44.168
5. Click "Submit"
```

You may need to wait a few minutes before the changes take effect. You may also need to find 'JMatPro\configs\system.def' file in your installation directory, put the IP address in the [ContactServer] field.

## Remote Desktop Method

The most straightforward way to use all of the above software is to use Windows Remote Desktop. This allows you to be effectively sat at the modelling PC without being there. You can use this from outside the University provided you connect via VPN to the University system first.
<https://www.itservices.manchester.ac.uk/ourservices/popular/vpn/>

For Windows 10, the Remote Desktop connection is straightforward. 
<https://support.microsoft.com/en-us/windows/how-to-use-remote-desktop-5fe128d5-8fb1-7a23-3b8a-41e636865e8c>

Details of the remote machine you will need to enter to log-in are:

```
IP: 130.88.44.168:56224
User: modelling	
```
**Please see the pinned post for the log-in password on the Slack channel #jmatpro_users**

You may get a warning message, which you can ignore and proceed. 
**Note: if another user is also trying to use the same computer, you may find you get logged out during your session. If this happens, you will need to wait and try again another time when the computer is not in use. Please check the booking form on the home screen and make a booking for the time you want to use the PC. If another user is booked at for the date/time you log in, please book another slot and log off.**
After logging in, you will see the desktop. Please do not close any other modeling windows if it appears they are still running a model (i.e. calculations not complete) as this will be another user’s work. For this reason it is an important discipline to close all modelling windows once you have finished and log-out.
If you use the machine remotely and wish to get access to your files the easiest way is to email them to yourself using Outlook webmail <https://outlook.live.com>. You can then open the email on your own computer and get the files.

## Thermodynamic Databases

We have the following additional databases for use in JMatPro. If you want to do multicomponent calculations, these should be the most accurate databases to use.
```
ALDATA – Aluminium alloy database 
MGDATA – Magnesium alloy database 
ZRDATA – Zirconium alloy database
TIDATA – Titanium alloy database
```

## ThermoCalc

Thermocalc can be accessed through Remote Desktop method only. Follow the instructions for this as for JMatPro (above).
