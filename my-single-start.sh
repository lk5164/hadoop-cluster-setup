hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs start namenode
hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs start datanode
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop start resourcemanager
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop start nodemanager
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop start proxyserver
mr-jobhistory-daemon.sh --config $HADOOP_HOME/etc/hadoop start historyserver


