#$ipaddr = "Enter server IP Address here"


Exec {
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin","/bin/bash"],
}

# If you want to run this manifest for a specified system, put the system name instead of default. Default means it will run all the systems.
# If you don't want to install any of this modules , Please do delete that line and execute this manifest.


node default {

## 1. VARIABLES ##

#### The following variables are used in configuring MYSQL ####
#### Delete or comment if not required ####	

$perconapasswd = 'citrus' 

#### Working directory which has installation binaries ####
#### Delete or comment if not required ####	  

$workingdirectory = "/root/setup"


## 2. MODULES ##

#### Module for Mysq server installation ####
#### Delete or comment if not required ####
	  
#class { 'mysql': 
#	password => $perconapasswd,
 #     }

#### Module Tomcat and Java installations ####
#### Delete or comment if not required ####

class { 'tomcat': 
	workingdir => $workingdirectory,
      }

}
