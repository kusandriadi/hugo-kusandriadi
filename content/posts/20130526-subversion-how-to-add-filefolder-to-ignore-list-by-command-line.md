---
title: 'Subversion : How to adding file/folder to ignore list with command line'
date: 2013-05-26T06:35:51+00:00
---
Maybe we had known how to add a file or folder (from this time and so on I will just said "file") on IDE. In this case, I often using Eclipse, and adding files as ignore list in eclipse is like shooting fish in a barrel. But occasionally we have to use a command-line to complete it. and do not worry, this is not too difficult. I will show you how 🙂
<!--more-->
There are two conditions of a file that we want to ignore. First, the file is already in svn repo, and the others not in svn yet. How we tackle these? Remember to always remove a file from svn repo first for this case. because we can not add a file to ignore the list while the file is on the repo. What we have to do just go to the directory of our repo in local, and just put the command below

```bash
$ svn rm --keep-local filename
```

The command above will remove our file from svn but will keep the file on our local. just simple. after this, we can add them to ignore list with the command below

```bash
$ svn propset svn:ignore filename .
```

look at the dot (.) sign at the end of the command, after you do that. voila, the file will be included in the ignoring list and will never be committed to the repository. this last command also applies to all files that never commit before to the repo.