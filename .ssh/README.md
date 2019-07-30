# SSH key management

    $: ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \\
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

Copy config file to .ssh folder. 
    
    cp ssh_config ~/.ssh/

Copying keys to slave machines is not required step. However when you execute start-dfs.sh or start-yarn.sh command, you need to manually input password. There are various way of copying public keys to other machine. I am using ssh-copy-id command, 
  
    ssh-copy-id [username]@[ip]
