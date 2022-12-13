#!/bin/bash

apt install unzip

wget https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip

unzip terraform*.zip

echo $PATH

mv ./terraform /usr/local/bin/

terraform --version

terraform -help plan

touch ~/.bashrc

terraform -install-autocomplete

source ~/.profile


