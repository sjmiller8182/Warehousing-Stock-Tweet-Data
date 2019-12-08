#! /bin/bash

# CLI command to start connection for web interface go to printed URL
# pem_key: /path/to/pem/key/file
# pub_dns_name: master public DNS name like ec2-###-##-##-###.compute-1.amazonaws.com
# port: ssh connection port
#

pem_key=${1}
pub_dns_name=${2}
port=${3:-8157}

printf '\nstarting ssh connection\n'
echo 'connect to http:\\'$pub_dns_name':8888'

# get Public DNS name of master node from instance list
yes | ssh -i $pem_key -N -D 8157 'hadoop@'$pub_dns_name
