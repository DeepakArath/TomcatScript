### Netspective Puppet Script for Server Side Installations and Configurations.

This puppet script different modules that needed for various server side installations and configurations. Configured each installation/configuration as separate modules.

**Server Configuration Management Setup**

Install Git and Puppet

`sudo apt-get install -y git-core puppet`

`cd $HOME` 

Clone the puppet script:

`sudo git clone http://gitlab.rcs.cm.netspective.com/netspective-infrastructure-management/netspective-puppet-script-for-installations.git`

`sudo cp -Rv netspective-puppet-script-for-installations/modules/* /etc/puppet/modules/`

`sudo cp netspective-puppet-script-for-installations/manifests/nodes.pp /etc/puppet/manifests/`

Edit `/etc/puppet/manifests/nodes.pp` to include the needed modules.

Some modules are included in class structure for passing variables. So please 
comment or delete the whole class definition and related variable declarations if it is not required for installation.

Select NFS Server or NFS Client.

Add proper variables for Amazone S3CMD and LDAP modules in `/etc/puppet/manifests/nodes.pp`.

Add the needed variable values in `/etc/puppet/manifests/nodes.pp` script.

`sudo puppet apply /etc/puppet/manifests/nodes.pp`

`sudo reboot`