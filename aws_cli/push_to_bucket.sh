#! /bin/bash/

# CLI command for pushing to the S3 bucket
# The push is recursive and quiet
#
# Args:
# $1: path to push
#

push_path=${1}

aws s3 cp $push_path s3://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse --recursive --quiet
