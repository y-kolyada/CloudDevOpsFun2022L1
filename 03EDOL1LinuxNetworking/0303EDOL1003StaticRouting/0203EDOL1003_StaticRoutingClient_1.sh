#!/bin/bash 
su ik

# Docs
# see 0203EDOL1003StaticRoutingMikrotik.sh

# Server_1 / server1
# vi /etc/sysctl.d/99-sysctl.conf
sudo sysctl net.ipv4.ip_forward
sudo sysctl net.ipv4.ip_forward=1
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<EOF
sudo sysctl net.ipv4.ip_forward=1
EOF

sudo apt install inetutils-traceroute
traceroute 10.0.10.1
