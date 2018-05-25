# Create loaders

Will create cluster of loader VMs from base GCP centos7 image, installing elfs_tools and all dependencies

Components

google_loaders.tf
Main terraform configuration file

terraform.tvars
Main terraform configuration variables file

erun.sh
erun script load parameters

dns.txt
DNS servers list

configure.sh
packages to install

configure_dns.sh
appends dns.txt to /etc/sysconfig/network-scripts/ifcfg-eth0

commander.sh
invokes erun.sh script for all matching instances. Run from local terraform directory.
./commander.sh <ERUN VM name> <ZONE> <PROJECT>
