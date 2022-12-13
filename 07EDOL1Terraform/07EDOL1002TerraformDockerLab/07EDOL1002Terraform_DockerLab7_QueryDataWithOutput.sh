#!/bin/bash

terraform destroy

terraform init

terraform apply

cat > vaiables.tf <<EOF
# variables.tf

variable "container_name" {
  description   = "Value of the name for the Docker container"
  type          = string
  default       = "ExampleNginxContainer"
}
EOF

cat <<EOF | tee -a outputs.tf
# outputs.tf

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id
}
EOF

terraform apply

terraform output

terraform destroy