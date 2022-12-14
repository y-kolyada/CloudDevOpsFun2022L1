#!/bin/bash 

# Prerequisites
#
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build


# export AWS_ACCESS_KEY_ID= ...
# export AWS_SECRET_ACCESS_KEY= ...

terraform init

terraform apply

terraform apply

cat << EOF > outputs.tf
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
EOF

terraform apply

terraform output

terraform destroy