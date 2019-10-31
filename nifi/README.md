# NiFi

## Setup 

The following steps are required for NiFi setup on an EC2 instance

### Preconfiguration

Some settings are required in the AWS deployment stage.

* In 'Security Groups,' add a custom TCP rule to allow web connection to nifi
  * Type: Custom TCP Rule
  * Protocol: TCP
  * Port Range: 8080 (as example), remember this port
  * Source: Add your IP address (for example); do not allow all connections (0.0.0.0)

### Install

Run [`./install_nifi.sh`](https://github.com/sjmiller8182/DBMS_Proj/blob/master/nifi/install_nifi.sh) to install nifi.

The install script installs the following

* java 8
* NiFi

### Configure

Configure nifi with the instance IP address

* `$ vi conf/nifi.properties`
* Set `nifi.remote.input.host` to the instance public IP address
* Save changes and close vi

### Restart and Connect

* Restart NiFi by calling `./bin/nifi.sh restart`
* Connect to NiFi UI
  * In a web browser connect to <Instance_IP_Address>:<Connection_Port>/nifi/
* Now NiFi should be up and running

#### References

The following page(s) were used as references:

* http://ijokarumawak.github.io/nifi/2017/01/27/nifi-s2s-local-to-aws/

#### TODO

* Add a CLI command to create/terminate this instance
