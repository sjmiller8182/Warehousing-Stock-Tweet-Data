#! /bin/bash

# CLI command for getting the DNS name of the EMR cluster
#

# just get the stored name of the EMR cluster
emr_cluster_name=$(head -n 1 cluster_name.txt)

# get Public DNS name of master node from instance list
aws emr describe-cluster \
        --cluster-id $emr_cluster_name \
        --region us-east-2 | \
        jq '.Cluster.MasterPublicDnsName'
