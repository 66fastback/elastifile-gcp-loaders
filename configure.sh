#!/bin/bash
sudo yum -y install nfs-utils
sudo yum -y install strace
sudo yum -y install net-tools
sudo yum -y groupinstall 'Development Tools'
sudo yum -y install nano
sudo yum -y install libaio
sudo yum -y install libunwind
sudo yum -y install protobuf-c-devel-1.0.2-3.el7.x86_64
sudo curl -O https://storage.googleapis.com/elastifile-upgrade-files/elfs-tools-2.5.0.1-47523.a8daec2c343a.el7.centos.x86_64.rpm.tar.gz
sudo tar -xf *.tar.gz
sudo rpm -Uvh *.rpm

# uncomment these to install linux test project NFS utils
# git clone https://github.com/linux-test-project/ltp.git
# cd ltp
# make autotools
# ./configure
# make
# make install
