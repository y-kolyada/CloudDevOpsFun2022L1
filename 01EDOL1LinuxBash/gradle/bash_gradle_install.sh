#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Fedora Linux 37

# Installing Gragle manually
# https://gradle.org/install/

# Prerequisites
# 1. Java JDK version 8 or higher
# 2. sudo:  ALL=(ALL) ALL
# 3. unzip, wget

sudo -l
java -version && unzip -v && wget -V

echo "Install err"
if [ $retVal -ne 0 ]; then
  echo "Install java, unzip, wget and set sudo rights"
  exit $retVal
fi

cd ~/install
wget https://services.gradle.org/distributions/gradle-7.6-bin.zip
unzip gradle-7.6-bin.zip
sudo mv gradle-7.6 /opt
ls /opt/gradle-7.6

touch cat ~/.bashrc
cat <<EOF>> ~/.bashrc
export PATH=\$PATH:/opt/gradle-7.6/bin
EOF
source ~/.bashrc

# Optional
cat <<EOF | sudo tee -a /etc/profile.d/gradle.sh
export PATH=\$PATH:/opt/gradle-7.6/bin
EOF
sudo source /etc/profile

gradle -v