#!/bin/bash

# Date: 2022-12-22
# Author: y-kolyada
# Tested: Fedora Linux 37, Ubuntu 22.04.1

# Prerequisites
# 1. Java SDK

cd ~
mkdir -p dev/src/java/HelloWorldApp
cd dev/src/java/HelloWorldApp

cat > HelloWorld.java <<EOF
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello Java World! Temurin OpenJDK is amazing!");
  }
}
EOF

javac HelloWorld.java

java HelloWorld
