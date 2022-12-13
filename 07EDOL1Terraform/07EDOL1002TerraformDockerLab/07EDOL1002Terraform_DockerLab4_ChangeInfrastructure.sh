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

terraform apply

sed -i 's/external = 8000/external = 8080/g' main.tf

terraform apply

terraform show