# JAVA 8 JDK Installation
Now Java 8 is not the default version, so I choose openjdk version which is still free. 

    add-apt-repository ppa:webupd8team/java
    
Update packages, and installing neccessary tools like wget and vim. 

    apt-get update && apt-get install -y openssh-server wget vim
    
Install Java,

    apt-get install openjdk-8-jdk
    
Verify the installation with:

    java -version
    
Make sure to set environment variables. I prefer to have it in /root/.bashrc

    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
