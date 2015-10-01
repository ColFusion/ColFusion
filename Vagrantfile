# -*- mode: ruby -*-
# vi: set ft=ruby :

#############################
##### Hardware Settings #####
#############################

# Usage: $ CF_CPUS=2 CF_MEM=3000 vagrant up

cpus = ENV['CF_CPUS']
if cpus.nil?
	cpus = 1
end
mem = ENV['CF_MEM']
if mem.nil?
	mem = 1536
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP. The host OS is available to the guest
  # at the "192.168.33.1" IP address.
  config.vm.network "private_network", ip: "192.168.33.11"
  
  # apache
  config.vm.network "forwarded_port", guest: 80, host: 50001
  
  # tomcat
  config.vm.network "forwarded_port", guest: 8080, host: 50002
  
  # openrefine
  config.vm.network "forwarded_port", guest: 3333, host: 50003

  config.vm.synced_folder ".", "/opt/Colfusion/ColFusion", create: true
  config.vm.synced_folder "../ColfusionOpenRefine", "/opt/Colfusion/ColfusionOpenRefine", create: true
  config.vm.synced_folder "../ColfusionServer", "/opt/Colfusion/ColfusionServer", create: true
  config.vm.synced_folder "../PentahoKettle", "/opt/Colfusion/PentahoKettle", create: true
  config.vm.synced_folder "../ColfusionWeb", "/opt/Colfusion/ColfusionWeb", create: true
  
  config.vm.synced_folder "assets/www", "/opt/www"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = mem
    vb.cpus = cpus
  end

  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "apache-cfweb", type: "shell", path: "provisioners/apache-cfweb.sh"
  config.vm.provision "mysql", type: "shell", path: "provisioners/mysql.sh"
  config.vm.provision "java", type: "shell", path: "provisioners/java.sh"
  config.vm.provision "neo4j", type: "shell", path: "provisioners/neo4j.sh"
  config.vm.provision "carte", type: "shell", path: "provisioners/carte.sh"
  config.vm.provision "docker", type: "shell", path: "provisioners/docker.sh"
  config.vm.provision "tomcat", type: "shell", path: "provisioners/tomcat.sh"
  config.vm.provision "maven", type: "shell", path: "provisioners/maven.sh"
  config.vm.provision "colfusion", type: "shell", path: "provisioners/colfusion.sh"
end
