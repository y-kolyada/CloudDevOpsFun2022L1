#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Fedora Linux 37, Ubuntu 22.04.1

# Installing Apache Maven manually
# https://gradle.org/install/

# Prerequisites
# 1. Maven 3.3+ require JDK 1.7 or above
# 2. sudo:  ALL=(ALL) ALL
# 3. wget

sudo -l
java -version && wget -V

$retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Install java, wget and set sudo rights"
  exit $retVal
fi

cd ~/install
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
tar xzvf apache-maven-3.8.6-bin.tar.gz
sudo mv apache-maven-3.8.6 /opt
ls /opt/apache-maven-3.8.6

touch cat ~/.bashrc
cat <<EOF>> ~/.bashrc
export PATH=\$PATH:/opt/apache-maven-3.8.6/bin
EOF
. ~/.bashrc

# Optional
cat <<EOF | sudo tee -a /etc/profile.d/maven.sh
export PATH=\$PATH:/opt/apache-maven-3.8.6/bin
EOF

mvn -v