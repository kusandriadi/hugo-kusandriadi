---
title: "How to add windows font in linux?"
date: 2012-01-14T15:29:15+00:00
---
You can find font like Tahoma, Arial, Times New Roman, Verdana, etc. in windows OS, but not in Linux. You will find a little problem because of that, the example one is, if you open document that using font there isn't exist, it will make your document untidy. So how to adding windows font in linux? it is very easy, there are 2 ways to adding windows font in linux.
<!--more-->

**1. Download from repository**

In default, there is windows font package in repository. You only need to execute this command below

```bash
$ sudo apt-get install ttf-mscorefonts-installer
```

but if you using this way, you will not find tahoma's font. I don't know why, but you can add it manually with the 2nd way.

**2. Copy windows font**

There are several step with this way :

  * Copy windows font, you can find it in "C:\Windows\Fonts" (Win7 based), put in 1 folder.
  * Login to Linux Mint (I am using LM 12 :p ) as root
  * Paste to "/usr/share/fonts/truetype"
  * Open terminal, type command below :

```bash
cd /usr/share/fonts/truetype
chmod 777 -R folder-name/*
```

  * Now, you can check it works or not. Open LibreOffice or OpenOffice. Is there Tahoma, Arial or Times New Roman? if still doesn't exist, Logout or restart your PC first.

Still there is no changes? just follow the instructions above one more time with carefully. it should be works without problem.