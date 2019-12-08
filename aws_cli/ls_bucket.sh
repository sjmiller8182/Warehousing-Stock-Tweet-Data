#! /bin/bash

# CLI command list files in data warehouse directory in S3

aws s3 ls s3://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/ \
		--human-readable
