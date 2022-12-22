#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Fedora Linux 37

# Installing Java on Fedora Linux 37
# https://adoptium.net/installation/linux/
# https://computingforgeeks.com/install-temurin-openjdk-on-centos-rhel-oracle-linux/
# https://github.com/adoptium/temurin8-binaries/releases
# https://github.com/adoptium/temurin8-binaries/releases/tag/jdk8u352-b08
# https://docs.fedoraproject.org/en-US/quick-docs/installing-java/
# https://tecadmin.net/install-java-on-fedora/

# Prerequisites
# 1. sudo:  ALL=(ALL) ALL
# 2. wget

sudo dnf install -y wget

sudo -l
wget -V

retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Install wget and set sudo rights"
  exit $retVal
fi

# Installing OpenJDK
# dnf search openjdk
# sudo dnf install java-1.8.0-openjdk.x86_64
# sudo dnf install java-11-openjdk.x86_64
# sudo dnf install java-latest-openjdk.x86_64

# Java Development Kit
# sudo dnf install java-1.8.0-openjdk-devel.x86_64
# sudo dnf install java-11-openjdk-devel.x86_64
# sudo dnf install java-latest-openjdk-devel.x86_64


# Installing Oracle Java SE
# sudo tar xf Downloads/jdk-18_linux-x64_bin.tar.gz -C /opt
# export JAVA_HOME=/opt/jdk-18.0.1.1

# sudo alternatives --config java

# https://github.com/adoptium/temurin8-binaries/releases

cd ~/install
wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u352b08.tar.gz
tar -xvf OpenJDK8U-jdk_x64_linux_hotspot_8u352b08.tar.gz
sudo mv jdk8* /opt/jdk-8

wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK11U-jdk_x64_linux_hotspot_11.0.17_8.tar.gz
tar OpenJDK11U-jdk_x64_linux_hotspot_11.0.17_8.tar.gz
sudo mv jdk11* /opt/jdk-11

touch cat ~/.bashrc
cat <<EOF>> ~/.bashrc
export JAVA_HOME=/opt/jdk-11
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
. ~/.bashrc

cat <<EOF | sudo tee -a /etc/profile.d/java.sh
export JAVA_HOME=/opt/jdk-11
export PATH=\$PATH:\$JAVA_HOME/bin 
EOF

sudo alternatives --install /usr/bin/java java /opt/jdk-8/bin/java 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk-8/bin/javac 2
sudo alternatives --install /usr/bin/java java /opt/jdk-11/bin/java 3
sudo alternatives --install /usr/bin/javac javac /opt/jdk-11/bin/javac 3

sudo alternatives --set java /opt/jdk-11/bin/java
sudo alternatives --set javac /opt/jdk-11/bin/javac

# sudo alternatives --config java
# sudo alternatives --config javac

java -version
javac -version
