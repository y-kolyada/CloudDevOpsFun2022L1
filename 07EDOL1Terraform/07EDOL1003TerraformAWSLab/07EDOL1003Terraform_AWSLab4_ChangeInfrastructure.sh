#!/bin/bash 

# Prerequisites
#
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build


# export AWS_ACCESS_KEY_ID= ...
# export AWS_SECRET_ACCESS_KEY= ...

mkdir learn-terraform-aws-instance

cd learn-terraform-aws-instance

touch main.tf

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-quick-start-ami
# +  vpc_security_group_ids = ["sg-0077..."]
# +  subnet_id              = "subnet-923a..."
# https://docs.aws.amazon.com/vpc/latest/userguide/working-with-vpcs.html

cat << EOF | tee -a main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
EOF

terraform init

terraform fmt

terraform validate

terraform apply

# change
# -  ami           = "ami-830c94e3"
# +  ami           = "ami-08d70e59c07c61a3a"

terraform apply
