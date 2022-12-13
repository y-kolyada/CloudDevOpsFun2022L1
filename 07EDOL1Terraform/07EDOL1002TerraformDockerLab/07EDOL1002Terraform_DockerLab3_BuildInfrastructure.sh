#!/bin/bash

mkdir learn-terraform-docker-container

cd learn-terraform-docker-container

cat << EOF > tee -a main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
EOF

terraform init

ll .terraform
ll .terraform.lock.hcl


terraform fmt

terraform validate

terraform apply

terraform show

terraform state list

terraform state show docker_image.nginx

terraform graph

terraform destroy

# https://developer.hashicorp.com/terraform/intro/use-cases

# https://developer.hashicorp.com/terraform/language/providers

# https://registry.terraform.io/providers/kreuzwerker/docker/latest







