# /root/.bashrc
Environment variables set here will be set automatically when system starts. 

# /etc/hosts
If you don't have a DNS Server, you need to configure hosts file to allow hadoop communicate servers with host names. You copy of hosts file needs to exists on every nodes. Because Map and Reduce process will requires communicates between slave nodes. To display host name for local machine, use command,

    hostnamectl
    
To update host name, 

    hostnamectl set-hostname [new host name]

Personally, I prefer comment out 127.0.01 for localhost. because when starting hadoop, sometimes, it will start the master node on 127.0.01 which won't be discoverable by other nodes. 
