# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP. The host OS is available to the guest
  # at the "192.168.33.1" IP address.
  config.vm.network "private_network", ip: "192.168.33.11"

  config.vm.synced_folder ".", "/opt/Colfusion"
  config.vm.synced_folder "assets/www", "/opt/www"
  config.vm.synced_folder "../ColfusionOpenRefine", "/opt/ColfusionOpenRefine"
  config.vm.synced_folder "../ColfusionServer", "/opt/ColfusionServer"
  config.vm.synced_folder "../PentahoKettle", "/opt/PentahoKettle"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
  end

  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "apache", type: "shell", path: "provisioners/apache.sh"
  config.vm.provision "mysql", type: "shell", path: "provisioners/mysql.sh"
  config.vm.provision "java", type: "shell", path: "provisioners/java.sh"
  config.vm.provision "neo4j", type: "shell", path: "provisioners/neo4j.sh"
  config.vm.provision "carte", type: "shell", path: "provisioners/carte.sh"
  config.vm.provision "docker", type: "shell", path: "provisioners/docker.sh"
end
