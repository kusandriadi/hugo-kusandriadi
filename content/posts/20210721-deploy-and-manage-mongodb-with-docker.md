---
title: "Deploy and Manage MongoDB with Docker"
date: 2021-07-20T16:55:31+00:00

---
## Introduction
MongoDB is NoSQL database platform. It doesn't use a fixed data structure like old school RDBMS like MySQL and PostgreSQL. It makes MongoDB becomes more scalable, because we are not bound with field or relational limitation. 

In this tutorial, I assume you have installed Docker in your machine. The steps should be the same for another image installation.
<!--more-->
For this tutorial, I am using docker version below :
{{< highlight bash >}}
kusa $ docker --version
Docker version 20.10.7, build f0df350
{{< /highlight >}}
## Download MongoDB Image from Docker
### Pull MongoDB Image
{{< highlight bash >}}
kusa $ docker pull mongo
Using default tag: latest
latest: Pulling from library/mongo
99006dae3b24: Pull complete 
0566436151d6: Pull complete 
f3e35ecfc23e: Pull complete 
a03a1be757b0: Pull complete 
7ea0d006dcea: Pull complete 
fb3446d972a9: Pull complete 
c476bc840c3d: Pull complete 
3dea434cd2cc: Pull complete 
233d505385d1: Pull complete 
aa0176c9085e: Pull complete 
Digest: sha256:2bf2258cb12f8d4086965fe794605571c715fa4815dbcc299ea9768783bf4fa1
Status: Downloaded newer image for mongo:latest
docker.io/library/mongo:latest
{{< /highlight >}}

Above command will pull the latest version of MongoDB, if you need to pull particular version, you can using command below :
{{< highlight bash >}}
kusa $ docker pull mongo:3.0.0
{{< /highlight >}}

### List Docker Images
You can list all docker images with "images" command 
{{< highlight bash >}}
kusa $ docker images
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
mongo        latest    0aacc5695653   21 hours ago   639MB
{{< /highlight >}}

We can see that I only have one docker image. Alternatively, you also can list all images using "ls"

{{< highlight bash >}}
kusa $ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
mongo        latest    0aacc5695653   21 hours ago   639MB
{{< /highlight >}}

You can see the different, first command using "images" with "s". The second using "image" with "ls"

## Deploy MongoDB image as a container
### Showing Running Container
You can check in your machine what container is online.
{{< highlight bash >}}
kusa $ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
{{< /highlight >}}

As you can see, I don't have any online container. We can go to the next step to see the differences.
### Deploy MongoDB
By default, MongoDB will store the data to **/data/db** in container, that means if we don't store the data in our local directory, the data will gone when we turn off the container. What we can do is mounting container data to local directory.
{{< highlight bash >}}
kusa $ sudo mkdir -p /mongodata
{{< /highlight >}}

I creating folder "mongodata", the folder will used for storing mongo data from container. Anyway, you can use any folder name. After that, go to that directory and start container
{{< highlight bash >}}
kusa $ docker run -d -v /Users/someone/code/mongodata:/data/db -p 27017:27017 --name mymongo -d mongo
9d120dc5fd4cd679ad5a589a2cf49839e0d7c27df9923f03a49f18cd264c3458
{{< /highlight >}}

| Command  | Description  |
|:----------|:----------|
| -d    | Run in background    |
| -v    | Mounting data from container to local (localPath:containerPath)    |
| -p    | expose/publish port to outside container    |
| -name    | Container name    |

Now, you can try to list running container again 
{{< highlight bash >}}
kusa $ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS       NAMES
9d120dc5fd4c   mongo     "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   27017/tcp   mymongo
{{< /highlight >}}

## Launch MongoDB Shell Client
MongoDB already run in the container, to access it from our local machine, we need to exec the container
{{< highlight bash >}}
kusa $ docker exec -it mymongo bash
root@9d120dc5fd4c:/# mongo
MongoDB shell version v5.0.0
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("e63ccdde-6eb6-4452-98c6-7d7c02ac2568") }
MongoDB server version: 5.0.0
{{< /highlight >}}

Congrats! You already connect to docker container, you can try to list all databases 
{{< highlight bash >}}
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
{{< /highlight >}}

## Start and Stop MongoDB Container
For starting the container, you can just simply do 
{{< highlight bash >}}
kusa $ docker start mymongo
{{< /highlight >}}

in reverse, for stopping container

{{< highlight bash >}}
kusa $ docker stop mymongo
{{< /highlight >}}

Remember, mymongo is container name that we set when creating the container.
## Conclusion
Now, you already know how to install and running container using docker. Eventhough the example in this article is using mongodb, I hope you have general understanding how to install images and creating container in docker.