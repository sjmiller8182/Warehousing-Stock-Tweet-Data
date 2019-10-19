#! /bin/bash

# CLI command to terminate current cluster

emr_cluster_name=$(head -n 1 cluster_name.txt)

aws emr terminate-clusters \
        --cluster-ids $emr_cluster_name \
        --region us-east-2 