---
title: How to run ABAQUS software as a GUI on the CSF via a Linux remote desktop 
author: Kevin Tanswell
---

1.	First contact the IT Services RI team: its-ri-team@manchester.ac.uk to setup a CSF user profile and provide the following details as per: http://ri.itservices.manchester.ac.uk/csf3/getting-started/user-accounts/
a.	The name of the system you wish to access – in this case the CSF
b.	A brief description of why you want to use the CSF
c.	your University IT Username (not password)
d.	your library card number
e.	the name of your PI/supervisor/line manager

2.	Download X2Go client from https://wiki.x2go.org/doku.php this is a Virtual Desktop Service required to access the CSF via a remote Linux desktop.

3.	You will need to again register with research IT to get a user profile for X2GO by emailing its-ri-team@manchester.ac.uk.

4.	Once you have a user profile from research IT and the X2GO software installed follow the setup guide steps here http://ri.itservices.manchester.ac.uk/virtual-desktop-service/x2go/linux/

5.	Login with your username and password to access the Linux remote desktop  

6.	Open a terminal window and select from the Applications / System Tools / MATE Terminal menu

7.	you can then login to the CSF by typing the following command into terminal and pressing enter.

## ssh csf3

8.	Type in password when requested and press enter

9.	Type in the following command to run Abaqus CAE (the Abaqus GUI) on a compute node. Maximum time allocated for interactive use is 1 hour. 
Ensure you enter all spaces and capitalise the V then press enter, to run Abaqus.

## qrsh -cwd -V -l short abq2019 cae -mesa

10.	A similar message to that given below will appear, to tell you which compute node is running and the number of available software licenses: 

Warning: Permanently added '[node404.pri.csf3.alces.network]:33877,[10.10.140.4]:33877' (ECDSA) to the list of known hosts
Abaqus License Manager checked out the following license: "cae" from Flexnet server lfarm4.its.manchester.ac.uk <112 out of 119 licenses remain available>
