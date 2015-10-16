### Puppet Script for Tomcat and JAVA Installation and Configurations in RGB environment.

This puppet script different modules that needed for various server side installations and configurations. Configured each installation/configuration as separate modules.

**Server Configuration Management Setup**

Install Git and Puppet

`sudo apt-get install -y git-core puppet`

`cd $HOME` 

Clone the puppet script:

`sudo git clone https://github.com/DeepakArath/TomcatScript.gitt`

`sudo cp -Rv TomcatScript/modules/* /etc/puppet/modules/`

`sudo cp TomcatScript/manifests/nodes.pp /etc/puppet/manifests/`

Edit `/etc/puppet/manifests/nodes.pp` to include the needed modules.

Some modules are included in class structure for passing variables. So please 
comment or delete the whole class definition and related variable declarations if it is not required for installation.

A directory needs to be specified in `/etc/puppet/manifests/nodes.pp` by the users where the script can query for Java and Tomcat binary tar's.

Add root password for mysql in `/etc/puppet/manifests/nodes.pp`.

Then,

`sudo puppet apply /etc/puppet/manifests/nodes.pp`

`sudo reboot`