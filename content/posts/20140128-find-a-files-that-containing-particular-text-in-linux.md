---
title: "Find files that containing particular text in Linux"
date: 2014-01-28T07:41:51+00:00
---
There is a case we want to find files that containing particular text. Unfortunately, we have 10000 files inside our folder. Should we check one by one? Yes, you should. Until you find a better way to solve this issue :). For me, it happened when I stored my configuration files into one folder, there are about 50+ files, and I want to know where are my files that I need. I do not want to ruin my time with opening files one by one. After a little googling, I found a better way to solve this. You can use :
<!--more-->

```bash
grep -H -R "string that we want to search" /path/to/directory | cut -d: -f1
```
Voila, you get the file that you needed 🙂