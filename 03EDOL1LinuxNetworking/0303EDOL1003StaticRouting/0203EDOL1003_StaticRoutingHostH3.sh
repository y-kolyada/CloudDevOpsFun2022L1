#!/bin/bash 
su ik

# Docs
# see 0203EDOL1003StaticRoutingMikrotik.sh

# Host 03 / h3
# Route to Net2 (Client_1)
route add -net 10.72.15.0 netmask 255.255.255.0 gw 10.0.10.200
# Route to Net3 (Client_2)
route add -net 10.3.72.0 netmask 255.255.255.0 gw 10.0.10.200
