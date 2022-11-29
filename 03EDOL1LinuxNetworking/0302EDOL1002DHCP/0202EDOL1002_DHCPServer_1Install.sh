#!/bin/bash 
su ik
mkdir ~/install
cd ~/install


# Docs
#
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-dhcp-configuring-server
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sect-configuring_a_multihomed_dhcp_server
# https://linuxhint.com/dhcp_server_centos8/

# server1
# vi /etc/sysctl.d/99-sysctl.conf
sysctl net.ipv4.ip_forward

# h3
route add -net 10.3.72.0 netmask 255.255.255.0 gw 10.3.72.1


# 01 
# Configuring a DHCP Server
sudo dnf install dhcp-server -y

# 02 
# Make config
sudo vi /etc/dhcp/dhcpd.conf

nmcli con sh int2 | egrep 'ipv4.addresses'


# 03
# Install the kernel-header and other development tools
sudo dnf install -y kernel-devel kernel-headers gcc make perl elfutils-libelf-devel
sudo dnf install -y wget
sudo reboot

# 04
# Set up VirtualBox repository
sudo wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import oracle_vbox.asc
sudo wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo

# 05
# Install VirtualBox
sudo dnf install -y VirtualBox-7.0
sudo systemctl status vboxdrv

# 06
# Install Oracle VM VirtualBox Extension Pack
sudo wget https://download.virtualbox.org/virtualbox/7.0.2/Oracle_VM_VirtualBox_Extension_Pack-7.0.2.vbox-extpack
sudo wget https://download.virtualbox.org/virtualbox/7.0.2/SHA256SUMS
VBSHA=$(sudo sed -n '1p' SHA256SUMS | awk '{ print $1 }')
sudo vboxmanage extpack install ./Oracle_VM_VirtualBox_Extension_Pack-7.0.2.vbox-extpack --accept-license=$VBSHA


# 07 Download Linux iso-image
wget https://pkg.adfinis.com/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-dvd1.iso
#wget https://pkg.adfinis.com/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso
#wget https://linuxsoft.cern.ch/cern/centos/s8/BaseOS/x86_64/os/images/boot.iso
#wget https://pkg.adfinis.com/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20221005-dvd1.iso


# 08
# Install VirtialBox guest like a host system

# 09
# Install VBoxGuestAdditions
# Device > Insert Guest Additions CD Image...

# 10
# Prepare guest Linux System
# Install the kernel-header and other development tools
sudo dnf install -y kernel-devel kernel-headers gcc make perl elfutils-libelf-devel
sudo dnf install -y wget
cd /run/media/ik/VBox_GAs_7.0.2
sudo VBoxLinuxAdditions.run

# 10
# Update giest Linux System
sudo dnf update -y
reboot

