#! /bin/bash

# CLI command for getting the DNS name of the EMR cluster
#

emr_cluster_name=$(head -n 1 cluster_name.txt)

aws emr list-instances --cluster-id $emr_cluster_name --region us-east-2
