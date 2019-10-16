#! /bin/bash

# CLI command for creating an EMR cluster
# The name of the cluster is written out to 'cluster_name.txt'
#
# Args:
# $1: pem key file path
#

key_path=${1}

# ssh tunnel to server (hue)
# example: ssh -i ~/mykeypair.pem -N -D 8157 hadoop@ec2-###-##-##-###.compute-1.amazonaws.com
ssh -i $key_path -N -D 8157 $dns_nam

# start browser with public address
x-www-browser http://some-url.orge
