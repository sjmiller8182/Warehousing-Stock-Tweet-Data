# NiFi

## Setup 

The following steps are required for NiFi setup on an EC2 instance

* Run the install script
* Set `nifi.remote.input.host` to IP address of the EC2 instance
* Call `./bin/nifi.sh restart` to restart the NiFi service

### Scripting

Run [`./install_nifi.sh`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/nifi/install_nifi.sh) to install nifi.

The install script installs the following

* java 8
* nifi
