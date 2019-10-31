# Project CLI

Details on the usage of the CLI for this project. 

## AWS CLI Setup

This is built on the [AWS CLI](https://aws.amazon.com/cli/).

### Prereqs

Install the AWS CLI and [configure the CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html). Get AWS CLI credentials from your AWS account.

```bash
$ sudo apt-get update
$ sudo apt-get install awscli
$ aws configure
```
## Project CLI Commands

### EMR

These scripts are used to work with AWS EMR clusters

* `create_cluster.sh`: This command spins up an EMR cluster. Optionally, takes a name as argument. 
Name of the cluster is written to `./cluster_name.txt`
  * us-east-2
  * m5.xlarge
  * 3 instances
* `get_DnsName.sh`: Gets the DSN name of the EMR cluster created by `create_cluster.sh` Name is printed to the screen.
* `./start_hue`: Starts and ssh connection to the cluster. The browser link is printed. SSH connection is left in foreground. Kill manually.
* `./terminate`: Terminates the current ERM cluster

```bash
# spin up an EMR cluster
$ sudo ./create_cluster
# wait for cluster to spin up then proced
$ sudo ./get_DnsName
DNSNAME
# start connect to server interactively (hue)
$ sudo ./start_hue /path/to/pem/file DNSNAME
# kill server when done
$ ./terminate
```

### S3

These scripts are used to work with S3 bucket for this project

* `push_to_bucket.sh`: Recursely and quietly copies files to S3 bucket for this project

```bash
# push a path to S3
$ sudo push_to_bucket.sh /path/to/push
```

### EC2

These scripts are used to work with AWS EC2 for this project

**TODO**

* Provisioning of NiFi instance
