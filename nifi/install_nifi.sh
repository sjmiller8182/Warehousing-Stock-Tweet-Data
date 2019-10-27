#! /bin/bash

# Script for installing nifi on an EC2 instance
# Call this with sudo

apt update
apt upgrade

# install java 8 for nifi
apt install openjdk-8-jdk

# install nifi
wget http://www-us.apache.org/dist/nifi/1.9.2/nifi-1.9.2-bin.tar.gz
tar xvf nifi-1.9.2-bin.tar.gz
cd nifi-1.9.2

# http://ijokarumawak.github.io/nifi/2017/01/27/nifi-s2s-local-to-aws/
# make an edit on nifi.remote.input.host; add address of ec2 instance
# then start with ./bin/nifi.sh restart

