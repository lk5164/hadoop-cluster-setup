# Hadoop Cluster Setup
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

## Ubuntu User And Role Setup
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
