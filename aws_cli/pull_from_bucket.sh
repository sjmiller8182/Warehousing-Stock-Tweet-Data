#! /bin/bash

# CLI command for pulling files from the S3 bucket
# The push is recursive and quiet
#
# Args:
# $1: local path to receive files
#

pull_path=${1}

aws s3 cp s3://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse $pull_path \
                          --acl public-read \
                          --recursive \
                          --quiet
