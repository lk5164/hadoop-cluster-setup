# SSH key generation

    $: ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \\
  
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    
# Copy Keys to Slaves
  
    ssh-copy-id [username]@[ip]
