---
title: "Error “File not found” in Linux Mint when using Ms. Office on Wine"
date: 2011-07-26T07:49:05+00:00
---
There is an error which is quite annoying if we install MS. Office on Linux Mint using Wine, it would appear error &#8220;File not found&#8221; or something like that when launch Ms. Office applications such as Ms. Word, Ms. Excel, etc. I get an information when i&#8217;m googling, it is because of bugs in mintmenu. Then, how do I fix it? There are several ways that we can run Ms. Office on Linux Mint
<!--more-->

  1. Using Gnome Menu, you can add it to applet, or pressing ALT + F1, you can run Ms. Office from Gnome Menu smoothly.

  2. Changing Ms. Office app properties in mintmenu, eg I have property Ms. Word on mintmenu like this:

> env WINEPREFIX=&#8221;/home/kusandriadi/.wine&#8221; wine C:\\windows\\command\\start.exe /Unix /home/kusandriadi/.wine/dosdevices/c:/users/kusandriadi/Start\ Menu/Programs/Microsoft\ Office/Microsoft\ Office\ Word\ 2007.lnk

and then you only have to change its properties like this

> env WINEPREFIX=&#8221;/home/kusandriadi/.wine&#8221; wine &#8220;C:\Program Files\Microsoft Office\Office12\WINWORD.exe&#8221;

Now, your Ms. Office app should be run properly from mintmenu normally 😀