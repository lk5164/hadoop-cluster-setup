hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs stop namenode
hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs stop datanode
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop resourcemanager
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop nodemanager
yarn-daemon.sh --config $HADOOP_HOME/etc/hadoop stop proxyserver
mr-jobhistory-daemon.sh --config $HADOOP_HOME/etc/hadoop stop historyserver


