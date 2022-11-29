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

ip a | grep "scope" | grep -Po '(?<=inet )[\d.]+'

sudo firewall-cmd --add-forward --permanent

