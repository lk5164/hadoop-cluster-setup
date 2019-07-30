# Hadoop Cluster Setup
This article walks you through setting up Hadoop 2.7.2 on Ubuntu. It is for people who is looking for fast installation solution on non-docker environment. For learning purpose, it doesn't involve HA architecture discussion. 

# Cluster Detail
* [Hadoop 2.7.2](https://github.com/apache/hadoop/releases/tag/rel%2Frelease-2.7.2)
* [Ubuntu 18.04.2 LTS](http://releases.ubuntu.com/18.04/)
## System Prerequisites
Use lsb_release -a command to check your ubuntu version.

    No LSB modules are available.
    Distributor ID:	Ubuntu
    Description:	Ubuntu 18.04.2 LTS
    Release:	18.04
    Codename:	bionic
    
Accoring to Ubuntu website, the 18.04.2 recommends, 

    2 GHz dual core processor or better
    4 GB system memory
    25 GB of free hard drive space
    Internet access is helpful

Before starting hadoop installation, sudo group user needs to be created. Use following commands to create user hadoop and its privileges. Starting with a root account. 
    
    adduser hadoop
    usermod -aG sudo hadoop
    
Next, a JDK and SSH needs to be installed and setup. 
* [Java 8 JDK Installation](jdk/README.md)
* [SSH Setup](.ssh/README.md)

## Core Configurations
## Environment Configurations
## Slave Configurations
## HDFS Trouble Shooting
    hadoop dfsadmin -report
# Reference
[Cluster Setup](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/ClusterSetup.html)

[core-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)

[hdfs-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)

[mapred-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)

[yarn-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
