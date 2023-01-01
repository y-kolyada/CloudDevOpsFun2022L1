#!/bin/bash

# Date: 2022-12-23
# Author: y-kolyada
# Tested: Fedora Linux 37, Ubuntu 22.04.1

# Installing Tomcat 9 manually
# https://techviewleo.com/install-apache-tomcat-server-on-ubuntu/

# Prerequisites
# 1. require JDK 1.8 or above
# 2. sudo:  ALL=(ALL) ALL
# 3. wget

REMOTE_IP="10.0.10.101"
TOMCAT_VER="apache-tomcat-9.0.70"

sudo -l
java -version && wget -V

$retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Install java, wget and set sudo rights"
  exit $retVal
fi

sudo setenforce 0
# sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
sudo reboot

cd ~/install
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.70/bin/${TOMCAT_VER}.tar.gz
tar xzvf ${TOMCAT_VER}.tar.gz
sudo mv ${TOMCAT_VER} /opt
# sudo touch ${TOMCAT_VER}/logs/catalina.out
ls /opt/${TOMCAT_VER}

sudo groupadd tomcat
sudo useradd -M -d /opt/${TOMCAT_VER} -g tomcat tomcat
# sudo usermod -aG tomcat tomcat

sudo chown -R tomcat:tomcat /opt/${TOMCAT_VER}
# sudo chmod -R u+x /opt/${TOMCAT_VER}/bin

# sudo systemctl disable tomcat9
# Removed "/etc/systemd/system/multi-user.target.wants/tomcat9.service".
sudo rm /etc/systemd/system/tomcat9.service

sudo tee -a /etc/systemd/system/tomcat9.service<<EOF
[Unit]
Description=Apache Tomcat 9
Documentation=http://tomcat.apache.org/tomcat-9.0-doc/
After=network.target syslog.target

[Service]
#Type=simple
Type=oneshot
User=tomcat
Group=tomcat

ExecStart=/opt/${TOMCAT_VER}/bin/startup.sh
ExecStop=/opt/${TOMCAT_VER}/bin/shutdown.sh
RemainAfterExit=yes

Environment="JAVA_HOME=/opt/jdk-11"
#Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=/opt/${TOMCAT_VER}"
Environment="CATALINA_HOME=/opt/${TOMCAT_VER}"
Environment="CATALINA_PID=/opt/${TOMCAT_VER}/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo usermod -aG tomcat ik

sudo systemctl restart tomcat9.service
sudo systemctl enable tomcat9
sudo systemctl status tomcat9.service

##Tomcat 9##
# sudo mkdir -p /etc/tomcat9/tomcat-users.xml
# sudo touch /etc/tomcat9/tomcat-users.xml
# cat <<EOF | tee -a /etc/tomcat9/tomcat-users.xml
# <role rolename="manager-gui" />
# <role rolename="admin-gui" />
# <user username="admin" password="admin" roles="manager-gui,admin-gui" />
# EOF
##Tomcat 10##
# sudo vim /opt/tomcat/conf/tomcat-users.xml

##Tomcat 9##
# sudo touch /etc/tomcat9/webapps/host-manager/META-INF/context.xml
# cat <<EOF | tee -a /etc/tomcat9/webapps/host-manager/META-INF/context.xml
# <Context antiResourceLocking="false" privileged="true" >
# <Valve className="org.apache.catalina.valves.RemoteAddrValve" 
# allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|$REMOTE_IP" />
# EOF
##Tomcat 10##
# sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml

##Tomcat 9##
# sudo touch /etc/tomcat9/webapps/manager/META-INF/context.xml
# cat <<EOF | tee -a /etc/tomcat9/webapps/manager/META-INF/context.xml
# <Context antiResourceLocking="false" privileged="true" >
# <Valve className="org.apache.catalina.valves.RemoteAddrValve" 
# allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|${REMOTE_IP}" />
# EOF

##Tomcat 10##
#sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml

sudo firewall-cmd --add-port=8080/tcp --permanent

touch cat ~/.bashrc
export CATALINA_HOME=${TOMCAT_VER}
export PATH=\$PATH:/opt/${TOMCAT_VER}/bin
EOF
. ~/.bashrc

# Optional
cat <<EOF | sudo tee -a /etc/profile.d/tomcat.sh
export CATALINA_HOME=${TOMCAT_VER}
export PATH=\$PATH:/opt/${TOMCAT_VER}/bin
EOF

# sudo vim /opt/${TOMCAT_VER}/conf/tomcat-users.xml
#  <role rolename="manager-gui,admin-gui" />
#  <user username="admin" password="admin" roles="manager-gui,admin-gui" />
#</tomcat-users>


