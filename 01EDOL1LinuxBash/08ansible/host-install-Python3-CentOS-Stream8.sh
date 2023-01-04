#!/bin/bash

dnf install -y epel-release
dnf install -y python39
alternatives --remove-all python
alternatives --install /usr/bin/python python /usr/bin/python3.9 111 --family python
# alternatives --set python /usr/bin/python3.9
# alternatives --config python <<< '1'
alternatives --list | grep python
python --version
