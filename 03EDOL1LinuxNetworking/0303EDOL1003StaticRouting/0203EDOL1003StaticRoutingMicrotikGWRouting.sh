#!/bin/bash 
export  file=add_cl1-cl2_network
# 10.0.10.2 - host server
add distance=1 dst-address=10.3.72.0/24 gateway=10.0.10.2
add distance=1 dst-address=10.72.15.0/24 gateway=10.0.10.2
add action=masquerade chain=srcnat comment="default configuration" out-interface=ether1-WAN-DG
