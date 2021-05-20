---
title: "Configure MySQL on OS X"
date: 2012-04-15T06:33:12+00:00
---
In this article, I will show you how to configure MySQL self install. First, you have to make sure there is .bash_login file in your home directory, if the file does not exist, just make the file and open that file with

```bash
edit .bash_login
```

Anyway, MySQL is install in **/usr/local/mysql** directory, you need to rename to **/usr/local/mysql-yourversion**. After that, you can put code below in .bash\_login
<!--more-->

```bash
\# Add the MySQL Home environment
export set MYSQL_HOME=/usr/local/mysql-yourversion

\# Add mysql directory to home path  
export set PATH=$PATH:$MYSQL_HOME/bin

\# Make an alias to start and stop mysql  
alias mysqlstart="/Library/StartupItems/MySQLCOM/MySQLCOM start"
alias mysqlstop="/Library/StartupItems/MySQLCOM/MySQLCOM stop"
```

After that you can save and close editor, close your terminal too and then open new session terminal, then input command like this :

```bash
which -a mysql
```

it should return your mysql directory :D. So, let's go to the next step, connect to your MySQL as root

```bash
mysql -u root  
use mysql;  
SELECT USER,password, host FROM USER
```

command above will show you mysql password and username, if you want to changes credential, just enter command below :

```bash
SET PASSWORD for "root@localhost" = password("iamhandsome");
```

Of course, you should not be follow me to set a password like that, it is not safe :p After that, do not forget to flush privileges MySQL to refresh your MySQL configuration. Now, you can enter MySQL admin with terminal and start/stop MySQL with command below

```bash
mysqlstart start  
//and  
mysqlstart stop
```