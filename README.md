# Hadoop Cluster Setup
This article walks you through setting up Hadoop 2.7.2 in fully distributed mode on Ubuntu. It is for people who is looking for fast installation solution on non-docker environment. For learning purpose, it doesn't involve HA architecture discussion. 

# Cluster Detail
* [Hadoop 2.7.2](https://github.com/apache/hadoop/releases/tag/rel%2Frelease-2.7.2)
* [Ubuntu 18.04.2 LTS](http://releases.ubuntu.com/18.04/)

A general architecture for 5 nodes is as follow.

    hadoop-master:            hadoop-slave1:       hadoop-slave2:      hadoop-slave3:      hadoop-slave4:
        | namenode              | namenode              | datanode          | datanode        | datanode
        | resourcemanager       | resourcemanager       | nodemanager       | nodemanager     | nodemanager
        | nodemanager           | nodemanager           | journalnode       | journalnode     | journalnode
        | zkfc                  | zkfc                  | zk                | zk              | zk
        
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

After formatting, the cluster IP in [VERSION](datanode/README.md) file will be regenerated. 
## Start Hadoop
To start dfs, the simpliest approach would be use, 

    start-dfs.sh
    
To start yarn,

    start-yarn.sh
    
Each step will start master node first, then start slave nodes. If you prefer to start/stop for a specific node for trouble shooting purpose, try the [my-single-start.sh](my-single-start.sh) and [my-single-stop.sh](my-single-stop.sh)

[my-single-start.sh](my-single-start.sh) lists steps in [hadoop website](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/ClusterSetup.html). 

Start the HDFS NameNode - 

    [hdfs]$ $HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
    
Start the HDFS DataNode - 

    [hdfs]$ $HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
    
Start the YARN ResourceManager -
    
    [yarn]$ $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
    
Start the YARN NodeManager -

    [yarn]$ $HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
    
Start a standalone WebAppProxy server - 

    [yarn]$ $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start proxyserver
    
Start the MapReduce JobHistory Server -

    [mapred]$ $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
    
Shutdown process follows the same order.     

## HDFS Trouble Shooting
Trouble shooting hdfs can be tricky, you can start from using following command,

    hdfs dfsadmin -report
    
A common problem is some of the nodes are not alive. Then ssh to the "dead" node and execute,

    jps
    
edit and execute [my-single-start.sh](my-single-start.sh) to try to bring the missing ones alive.
Then check relative logs under logs folder.

Finally, I am listing some common errors here with solutions.
For logs,
* [Permission Denied for logs](https://askubuntu.com/questions/37786/permission-denied-errors-whe-starting-a-single-node-cluster-in-hadoop)

For data nodes,

* [java.net.BindException: Problem binding to [0.0.0.0:50010] java.net.BindException](https://community.hortonworks.com/questions/50261/data-node-down-javanetbindexception-address-alread.html) - If the solutions doesn't work, try restart your phyiscal node server and try again. 
* [All specified directories are failed to load](https://stackoverflow.com/questions/45142320/hadoop-exception-all-specified-directories-are-failed-to-load)
* [Datanode not starts correctly
](https://stackoverflow.com/questions/22316187/datanode-not-starts-correctly)
# Reference
[Cluster Setup](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/ClusterSetup.html)

[core-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)

[hdfs-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)

[mapred-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)

[yarn-site.xml properties](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
