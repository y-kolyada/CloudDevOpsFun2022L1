#!/bin/bash 

# https://superuser.com/questions/1321328/can-we-change-the-dhcp-client-id-from-etc-network-interfaces
# In ubuntu 18.04-20.04 DHCP client-id generates from /etc/mashine-id
# After cloning VMs you must change /etc/mashine-id , /etc/hostname and /etc/hosts
# If you forget to change /etc/mashine-id , you will get same client-id and ip-address.


su ik
mkdir ~/install
cd ~/install

# 01 
# Processor supports hardware virtualization
egrep -c '(vmx|svm)' /proc/cpuinfo

# 02 
# Update System
sudo dnf update -y

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

