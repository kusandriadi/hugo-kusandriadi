---
title: "Find and kill running process in Linux"
date: 2014-01-29T06:48:54+00:00
---
There are several ways to kill a process in Linux, all of them are very straightforward, you can kill the process directly from a terminal using a certain port or just kill the application directly. In this article, I will only discuss 3 of them. Be wisely, just stopping the process that you know and do not be careless, stopping the process that related to operating system could mess up your day 🙂

<!--more-->
As far as we know, all operating systems (without exception) have limited resources. Include memory, port, storage, etc. What should we do is ensure all those resources comply with our needs. There is a condition that we got hang in our apps and operating system needs time to recover those resources. For example, I am using a web server (tomcat) that uses port 8181, then my tomcat gets crash/hang. what should I do is shut down the tomcat service and start again. Unfortunately, the operating system still booked port 8181, With this condition, we have an option to kill that port by our self or just waiting until operating system realized this problem and clears that port. If your choice is to kill the port by your self, here we go 
## Using fuser
If you have known what port should be stopped, just open terminal or press CTRL+ALT+T, then use the following command :

```bash
$fuser -k 8181/tcp
```
the command above will kill the process, to check whether the port has been free, you can use this :
```bash
$fuser 8181/tcp
```
## Using netstat
Open your terminal or press CTRL +ALT+T, then use the following command :

```bash
$netstat -anp | grep 8181
```
with netstat, you will get more detail information about the port. for example :

```bash
tcp ? ? ? ?0 ? ? ?0 0.0.0.0:8181 ? ? ? ? ? ? ? ?0.0.0.0:* ? ? ? ? ? ? ? ? ? LISTEN ? ? ?16360/java
```
the PID number is 16360, After you are sure that everything is OK. just kill the port with this command :
```bash
$sudo kill -9 16360
```
## Using History of application
This way is my favorite, I just need the name of the application, with the following command :

```bash
$ps -ef | grep tomcat
```

the output would be like this :

```bash
kusa ? ? 16660 ? ? 1 14 13:29 pts/2 ? ?00:00:04
```
the PID number is 16660, the same way as before. Just kill the apps using the PID information :

```bash
$sudo kill -9 16360
```
That is all, The first and the second way is used when you have known the port already. very simple. just like shooting fish in a barrel 🙂