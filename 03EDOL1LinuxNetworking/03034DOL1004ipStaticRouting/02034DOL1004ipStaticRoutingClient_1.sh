#!/bin/bash

sudo nmcli c s
sudo nmcli con modify "Wired connection 1" connection.id int1
sudo nmcli con modify "Wired connection 2" connection.id int2
sudo nmcli c s

sudo nmcli d s
sudo nmcli con modify int2 connection.interface-name enp0s8
sudo nmcli device connect enp0s8
sudo nmcli con modify int2 ipv4.method manual ipv4.addresses 172.16.15.11/24 ipv4.gateway ""
sudo nmcli device s
sudo nmcli connection s
ping 172.16.15.11



sudo nmcli connection add type ethernet con-name local01 ifname lo ip4 172.17.25.1/24

sudo nmcli con add type ethernet connection.interface-name lo connection.id int2 autoconnect yes save yes


