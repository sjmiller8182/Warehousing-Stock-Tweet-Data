#! /bin/bash

# CLI command for creating an EMR cluster
# The name of the cluster is written out to 'cluster_name.txt'
#
# Args:
# $1: cluster name (str)
#

name_cluster=${1:-'EMR_Cluster'}

aws emr create-cluster --applications Name=Ganglia Name=Hadoop Name=Hive Name=Hue Name=Mahout Name=Pig Name=Tez \
                       --ec2-attributes '{"KeyName":"EMR","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-191d3571","EmrManagedSlaveSecurityGroup":"sg-041f967b6784dd891","EmrManagedMasterSecurityGroup":"sg-0873f83eb4e5a8074"}' \
                       --service-role EMR_DefaultRole \
                       --enable-debugging \
                       --release-label emr-5.27.0 \
                       --log-uri 's3n://aws-logs-702437151295-us-east-2/elasticmapreduce/' \
                       --name $name_cluster \
                       --instance-groups '[{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core Instance Group"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master Instance Group"}]' \
                       --region us-east-2 | \
                       python -c "import sys, json; print(json.load(sys.stdin)['ClusterId'])" > cluster_name.txt

# 
