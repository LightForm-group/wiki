---
title: Using Git
author: Peter Crowther
tags:
  - git
  - version control
published: true
---

Git is a free and open source distributed version control system useful for versioning textual data. This could be code or data for making a paper. Git is not so good at storing very large files or binary files as these can make the repository very large.

## Getting Git

Get git here: https://git-scm.com/

## Git glossary

One of the reasons people struggle to start with git is its terminology. Here is a short summary of the basic git commands.

These commands work in any directory:
* git init - start a new git repository in the current directory
* git clone "url" - Make a local copy of the git repository at "url"

Both of these initialise a git repository in the current directory by adding the hidden ".git" folder. This holds the git magic so don’t change or delete anything in this folder.

These commands will work in an initialised git directory:
* git status - show the status of the current directory
* git log - show the log for recent commits in the repository
* git add "file_name" - add "file_name" to the staging area for the next commit
* git commit - Add the currently staged files as a commit
* git checkout "id" - Checkout the commit with commit id = "id"

These commands work when you have set up a remote:
* git pull - Incorporates changes from a remote repository into your local repository
* git push - Push any changes in the local repository to the remote

## Git GUIs

While you will occasionally need to use the command line to access advanced features, for the most part you can use a graphical interface.

* I would recommend GitHub Desktop: https://desktop.github.com/ for beginners who have not used git before and only want to use basic features. It is multiplatform, free and open source.
* For a more complete interface with nice branch visualisation I would recommend GitExtensions: https://github.com/gitextensions/gitextensions. Git extensions V3 is Windows only but V2 supports all platforms and is not that much older. It is free and open source.
* As an alternative GitKraken is really nice though it is proprietary and some features are subscriber only: https://www.gitkraken.com

## GitHub

GitHub is an online service for storing remote copies of repositories. While you can use git entirely as a local version control system, the advantage of having a remote repository is that you can synchronise your work over multiple computers and collaborate with others. We use a GitHub community to keep our groups code which you can access here: https://github.com/LightForm-group
