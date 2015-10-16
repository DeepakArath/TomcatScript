class java::install {

$jcat1 = 'JAVA_HOME=/usr/local/java/jdk'
$jcat2 = 'PATH=$PATH:$HOME/bin:$JAVA_HOME/bin'
$jcat3 = 'JRE_HOME=/usr/local/java/jre'
$jcat4 = 'PATH=$PATH:$HOME/bin:$JRE_HOME/bin'
$jcat5 = 'export JAVA_HOME'
$jcat6 = 'export JRE_HOME'
$jcat7 = 'export PATH'
$jcat8 = 'sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jre/bin/java" 1'
$jcat9 = 'sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk/bin/javac" 1'
$jcat10 = 'sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jre/bin/javaws" 1'
$jdir = '/usr/local/java/'

exec {"java0":
       command => "mkdir -p /usr/local/java",
     }
 
exec {"java1":
       cwd => "${tomcat::workingdir}/",
       command => "mv jre-7u79-linux-x64.gz /usr/local/java/",
       require => Exec["java0"],
     }

exec {"java2":
       cwd => "${tomcat::workingdir}/",
       command => "mv jdk-7u79-linux-x64.gz /usr/local/java/",
       require => Exec["java1"],
     }

exec {"java3":
       cwd => "${jdir}",
       command => "/bin/tar -xvzf jdk-7u79-linux-x64.gz",
       require => Exec["java2"],
     }

exec {"java4":
       cwd => "${jdir}",
       command => "/bin/tar -xvzf jre-7u79-linux-x64.gz",
       require => Exec["java3"],
     }

exec {"java5":
       cwd => "${jdir}",
       command => "ln -s /usr/local/java/jdk1.7.0_79 jdk",
       require => Exec["java4"],
     }

exec {"java6":
       cwd => "${jdir}/",
       command => "ln -s /usr/local/java/jre1.7.0_79 jre",
       require => Exec["java5"],
     }

exec {"java7":
     command => "echo '${jcat1}' >> /etc/profile",
     require => Exec["java6"],
     }
exec {"java8":
     command => "echo '${jcat2}' >> /etc/profile",
     require => Exec["java7"],
     }
exec {"java9":
     command => "echo '${jcat3}' >> /etc/profile",
     require => Exec["java8"],
     }
exec {"java10":
     command => "echo '${jcat4}' >> /etc/profile",
     require => Exec["java9"],
     }
exec {"java11":
     command => "echo '${jcat5}' >> /etc/profile",
     require => Exec["java10"],
     }
exec {"java12":
     command => "echo '${jcat6}' >> /etc/profile",
     require => Exec["java11"],
     }
exec {"java13":
     command => "echo '${jcat7}' >> /etc/profile",
     require => Exec["java12"],
     }
exec {"java14":
     command => "${jcat8}",
     require => Exec["java13"],
     }
exec {"java15":
     command => "${jcat9}",
     require => Exec["java14"],
     }
exec {"java16":
     command => "${jcat10}",
     require => Exec["java15"],
     }
exec {"java17":
     command => "sudo update-alternatives --set java /usr/local/java/jre/bin/java",
     require => Exec["java16"],
     }
exec {"java18":
     command => "sudo update-alternatives --set javac /usr/local/java/jdk/bin/javac",
     require => Exec["java17"],
     }
exec {"java19":
     command => "sudo update-alternatives --set javaws /usr/local/java/jre/bin/javaws",
     require => Exec["java18"],
     }
}

class tomcat::install {

$cat1 = 'CATALINA_HOME=/opt/tomcat'
$cat2 = 'PATH=$PATH:$HOME/bin:$CATALINA_HOME/bin'
$cat3 = 'export CATALINA_HOME'
$cat4 = 'export PATH'
$optf = '/opt/'

exec {"tom1":
       cwd => "${tomcat::workingdir}/",
       command => "mv apache-tomcat-7.0.37.tar.gz /opt/",
     }

exec {"tom2":
       cwd => "${optf}",
       command => "/bin/tar -xvzf apache-tomcat-7.0.37.tar.gz",
       require => Exec["tom1"],
     }

exec {"tom3":
       cwd => "${optf}",
       command => "ln -s /opt/apache-tomcat-7.0.37 tomcat",
       require => Exec["tom2"],
     }

exec {"tom4":
       command => "echo '${cat1}' >> /etc/profile",
     require => Exec["tom3"],
     }
exec {"tom5":
       command => "echo '${cat2}' >> /etc/profile",
       require => Exec["tom4"],	
     }

exec {"tom6":
       command => "echo '${cat3}' >> /etc/profile",
       require => Exec["tom5"],     
     }

exec {"tom7":
       command => "echo '${cat4}' >> /etc/profile",
       require => Exec["tom6"],
     }
}


class tomcat::start {

file    {  "tomcat-startup":
             path  => "/etc/init.d/tomcat",
             source => "puppet:///modules/tomcat/tomcat",
             mode => 755,
             owner   => "root",
             group   => "root",
             ensure    => present,
        }

exec {"jstart1":
       command => "sudo ln -s /etc/init.d/tomcat /etc/rc1.d/K99tomcat",
       require => File["tomcat-startup"],
     }

exec {"jstart2":
       command => "sudo ln -s /etc/init.d/tomcat /etc/rc2.d/S99tomcat",
       require => Exec["jstart1"],
     }
}

class tomcat  ($workingdir) {
             include java::install
             include tomcat::install
             include tomcat::start
             } 

