#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Ubuntu 22.04.1

# Installing Java on Ubuntu
# https://adoptium.net/installation/linux/
# https://askubuntu.com/questions/1157417/install-adoptopenjdk-adoptium-onto-ubuntu
# https://techviewleo.com/install-adoptium-temurin-openjdk-on-ubuntu/

# Prerequisites
# 1. Java JDK version 8 or higher
# 2. sudo:  ALL=(ALL) ALL
# 3. wget, apt-transport-http

sudo apt install -y wget apt-transport-https

sudo -l
wget -V

retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Install wget and set sudo rights"
  exit $retVal
fi


# sudo mkdir -p /etc/apt/keyrings
# wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo apt-key add -

# echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update

sudo apt install -y temurin-8-jdk

sudo apt install -y temurin-11-jdk

java_ver=$(sudo update-alternatives --list java | grep temurin-11-jdk)
javac_ver=$(sudo update-alternatives --list javac | grep temurin-11-jdk)

# sudo update-alternatives  --install /usr/bin/java java ${java_ver} 1112
# sudo update-alternatives  --install /usr/bin/javac java ${javac_ver} 1112


sudo update-alternatives --set java ${java_ver}
# sudo update-alternatives --config java

sudo update-alternatives --set javac ${javac_ver}
# sudo update-alternatives --config javac

java -version
javac -version
