#!/bin/bash

dnf install -y epel-release
python3 -m ensurepip --upgrade
pip install --upgrade pip
# dnf install -y ansible
# python3 -m pip install --user ansible-core==2.14.1
python3 -m pip install --upgrade --user ansible

absible --version
ansible-config view