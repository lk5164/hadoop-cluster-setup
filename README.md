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
* [Host Names Setup](root/README.md)

## Core Configurations
Switch to hadoop user and create folders for name node, data node and logs. 

    mkdir -p ~/hdfs/namenode && \ 
        mkdir -p ~/hdfs/datanode && \
        mkdir $HADOOP_HOME/logs

I would recommend setting above folders in a place where can be accessed by hadoop user. Otherwise you need to manually set folder privilege. 
    
    sudo chown -R hadoop [folder name]
    
Replace with configurations files under hadoop folder with root user.

    mv hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv mapred-env.sh $HADOOP_HOME/etc/hadoop/mapred-env.sh && \
    mv mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv slaves $HADOOP_HOME/etc/hadoop/slaves
    
## Slave Configurations
$HADOOP_HOME/etc/hadoop/slaves file contains slave server configurations. It is a plain text file with slave host names or IP address. If you install the master hadoop node with root account. You may want to specify user name in slave file. E.g., 

    hadoop@hadoop-slave1
    hadoop@hadoop-slave2
    ...

After adding a new slave record, use 

    hdfs dfsadmin -refreshNodes
    
to allow hdfs discover. 
## Name Node Formatting
If everything configures correctly, you can start formatting name node which is the last step before starting hadoop.

    hdfs namenode -format
    
According to Hadoop website,

    -format [-clusterid cid]	Formats the specified NameNode. It starts the NameNode, formats it and then shut it down. Will throw NameNodeFormatException if name dir already exist and if reformat is disabled for cluster.
    
## HDFS Trouble Shooting
    hdfs dfsadmin -report
# Reference
[Cluster Setup](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/ClusterSetup.html)

[core-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)

[hdfs-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)

[mapred-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)

[yarn-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
