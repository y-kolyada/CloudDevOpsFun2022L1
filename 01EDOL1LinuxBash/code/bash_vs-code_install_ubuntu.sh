#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Ubuntu 22.04.1

# Installing Visual Studio Code manually
# https://code.visualstudio.com/docs/setup/linux
# https://code.visualstudio.com/Download

# Prerequisites
# 1. sudo:  ALL=(ALL) ALL
# 2. wget, gpg, apt-transport-https

sudo -l

sudo apt install wget gpg apt-transport-https

cd ~/install

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

rm -f packages.microsoft.gpg

sudo apt update

sudo apt install code