
# Steps

## Prereq

* Setup foxyproxy: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-connect-master-node-proxy.html
* Create key pair: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair
* Create an S3 Bucket: https://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html

More info: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-gs-prerequisites.html

## Cluster Creation

* Launch EMR cluser: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-gs-launch-sample-cluster.html
* Allow SSH: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-gs-ssh.html
    * Be sure to add IP address

## Connect to the cluster (Hue)

* Open an ssh tunnel: ssh -i ~/mykeypair.pem -N -D 8157 hadoop@ec2-###-##-##-###.compute-1.amazonaws.com
* Enter address into browser: http://master public DNS:8888

## Connect to the cluster (CI)

* Open an ssh tunnel: ssh -i ~/mykeypair.pem hadoop@ec2-###-##-##-###.compute-1.amazonaws.com



aws emr create-cluster --applications Name=Ganglia Name=Hadoop Name=Hive Name=Hue Name=Mahout Name=Pig Name=Tez --ec2-attributes '{"KeyName":"EMR","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-191d3571","EmrManagedSlaveSecurityGroup":"sg-041f967b6784dd891","EmrManagedMasterSecurityGroup":"sg-0873f83eb4e5a8074"}' --service-role EMR_DefaultRole --enable-debugging --release-label emr-5.27.0 --log-uri 's3n://aws-logs-702437151295-us-east-2/elasticmapreduce/' --name 'My Cluster' --instance-groups '[{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core Instance Group"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master Instance Group"}]' --scale-down-behavior TERMINATE_AT_TASK_COMPLETION --region us-east-2
