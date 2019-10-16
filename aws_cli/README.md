# CLI Commands

Details on the usage of the CLI for this project.

* `create_cluster.sh`: This command spins up an EMR cluster. Optionally, takes a name as argument. 
Name of the cluster is written to `./cluster_name.txt`
  * us-east-2
  * m5.xlarge
  * 3 instances
* `get_DnsName.sh`: Gets the DSN name of the EMR cluster created by `create_cluster.sh`
