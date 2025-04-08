---
title: UNIX for dummies - How to navigate mac OS terminal and the CSF
author: Guy Bowker
tags:
  - simulation
  - csf
  - UNIX
toc: true
published: true
subcollection: CSF
---

## UNIX interface

The terminal is a very powerful interface based in the UNIX language with which you can do everything you could usually do using a mouse cursor and windows. Using a variety of commands,  directories and files can be created, moved and copied. Programs can be installed, ran and debugged from the command line. Here is where you can start to appreciate the utility of typing commands over clicking and dragging icons.

## Accessing the command line
To access the terminal on mac, go to launchpad, and search 'Terminal'. This uses 'bash'. Opening this will bring up a black window with some lines of code. Lets walk you through it:
```bash
Last login: Fri Mar 12 10:38:17 on ttys002
Y15576GB@C-LOSX1EVL410 ~ % <TYPE A COMMAND HERE>
```
This is my terminal. The first line is telling me the date and time of my last login, while the second line is telling me the user (Y15576GB) and the machine (LOSX1EVL410). Here <> is used to indicate where you could type a command. The <> should be ommitted to run the command.

On windows, the equivalent is powershell. You can use CMD, however some commands are different. Search powershell in the searchbar on the bottom left of windows 10 and open it.

## How to navigate the grid and create files

You can navigate file directories as you would on windows or mac file explorers. In both windows and mac, you begin at your user directory, which contains Desktop, Pictures, Downloads etc. To move to Desktop and view its contents as you would by double-clicking the icon, type `cd Desktop` and press enter. Remember that filenames are case-sensitive and will not open unless exact. To move back to the previously-viewed directory (as if clicking the back button) use `cd -`. To list the contents of the file your pointer is currently in, use `ls` (sometimes `dir` in windows). To move from a directory to the directory containing the one you are in, use `cd ..`. To create a new directory (similar to clicking 'new folder') use `mkdir <chosen_name>`. Remember to use a name not seperated by spaces but underscores (_) instead. To delete a directory use `rm -r <chosen_name>`. *Be very careful here*, as deleting a file from the command line is perminent. (unlike sending to the rescycle bin)

## Helpful Youtube resources

- [A playlist on basics of using the terminal](https://www.youtube.com/playlist?list=PLII6oL6B7q78PKy6_R6JTkkYjVXZBZcVq)
- [Installing Anaconda by Joao](https://www.youtube.com/watch?v=EbYGBANqDdY)
