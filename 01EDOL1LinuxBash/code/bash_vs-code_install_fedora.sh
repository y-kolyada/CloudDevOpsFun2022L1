#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Fedora Linux 37

# Installing Visual Studio Code manually
# https://code.visualstudio.com/docs/setup/linux
# https://code.visualstudio.com/Download

# Prerequisites
# 1. sudo:  ALL=(ALL) ALL

sudo -l

cd ~/install

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

dnf check-update

sudo dnf install code