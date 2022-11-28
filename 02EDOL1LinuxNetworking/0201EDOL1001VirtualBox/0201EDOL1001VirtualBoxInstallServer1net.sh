#!/bin/bash 
su ik

# Docs
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmcli
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-using_networkmanager_with_sysconfig_files
# https://unix.stackexchange.com/questions/501260/where-does-network-manager-store-settings
# https://developer-old.gnome.org/NetworkManager/stable/nmcli-examples.html
#
# !!! https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel/
#

# Print current NetworkManager configuratuion
NetworkManager --print-config
sudo nmcli -p -f general device show
sudo nmcli -f NAME,DEVICE,FILENAME con sh


# Change /etc/NetworkManager/NetworkManager.con
sed -i 's/#plugins=ifcfg-rh.*/plugins=ifcfg-rh/g' /etc/NetworkManager/NetworkManager.conf 

# 01 
# Install net-tools and network-scripts
sudo dnf install net-tools
sudo dnf install NetworkManager-initscripts-updown
#sudo dnf install network-scripts


cd /etc/sysconfig/network-scripts
ls -l


sudo nmcli --help
sudo nmcli device # nmcli d
sudo nmcli connection # nm c
sudo nmcli c --help
sudo nmcli connection show
sudo nmcli con modify int1 ipv4.method manual ipv4.addresses 10.0.10.200/24 ipv4.gateway 10.0.10.2
sudo nmcli con add type ethernet connection.interface-name enp0s8 connection.id int2 autoconnect yes save yes
sudo nmcli con modify int2 ipv4.method manual ipv4.addresses 10.72.15.1/24 ipv4.gateway ""
sudo nmcli con add type ethernet connection.interface-name enp0s9 connection.id int3 autoconnect yes save yes
#sudo nmcli c add type ethernet ifname enp0s9 con-name "int3" autoconnect yes save yes
sudo nmcli con modify int3 ipv4.method manual ipv4.addresses 10.3.72.1/24 ipv4.gateway ""
#sudo nmcli con load /etc/sysconfig/network-scripts/ifcfg-int2
#sudo nmcli con load /etc/sysconfig/network-scripts/ifcfg-int3
sudo nmcli -p -f NAME,DEVICE,FILENAME con sh
#
# Only the type argument is mandatory
# ifname is mandatory for all types except bond, team, bridge and vlan
#sudo nmcli c add type ethernet ifname enp0s9 con-name "int3"
#sudo nmcli c add type ethernet ifname enp0s9 con-name "int3" ethernet.mtu 1600
#sudo nmcli c add connection.type ethernet ifname enp0s9 con-name "int3" ethernet.mtu 1600
#sudo nmcli c add connection.type ethernet connection.interface-name enp0s9 connection.id  "int3" ethernet.mtu 1600
#sudo nmcli c modify "int3" ethernet.mtu 1600 
#sudo nmcli con up int3
#sudo nmcli device status
sudo nmcli c s
# or
# sudo nmcli con edit int3
# nmcli> help
# nmcli> describe ipv4
# nmcli> describe ipv4.addesses
# nmcli> set ipv4.method manual
# nmcli> set ipv4.addresses 10.3.72.1/24
# nmcli> set ipv4.gateway 10.0.10.1
# nmcli> save
# nmcli> quit
sudo nmcli connection up int2
sudo nmcli c up int3
