#!/bin/bash
sudo cat DNS.txt | sudo tee -a /etc/sysconfig/network-scripts/ifcfg-eth0
sudo systemctl restart network
