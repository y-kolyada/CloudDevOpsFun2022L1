#!/bin/bash

cat << EOF > tee -a vaiables.tf
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleNginxContainer"
}
EOF

terraform apply

terraform apply -var "container_name=YetAnotherName"

# https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables
