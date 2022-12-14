#!/bin/bash 

# Prerequisites
#
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build


# export AWS_ACCESS_KEY_ID= ...
# export AWS_SECRET_ACCESS_KEY= ...

cat << EOF > variables.tf
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
EOF


# Change main.tf
#
# -    Name = "ExampleAppServerInstance"
# +    Name = var.instance_name

terraform apply

terraform apply -var "instance_name=YetAnotherName"