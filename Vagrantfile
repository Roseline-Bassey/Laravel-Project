Vagrant.configure("2") do |config|

  ### Master Node ###
  config.vm.define "masternode" do |masternode|
    masternode.vm.box = "ubuntu/jammy64"
    masternode.vm.hostname = "masternode"
    masternode.vm.network "private_network", ip: "192.168.56.22"
    masternode.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1000"
    masternode.vm.provision "shell", path: "lampstack.sh" 
    masternode.vm.provision "shell", path: "laravel.sh" 
    end
  end

  ### Slave Node ###
  config.vm.define "slavenode" do |slavenode|
    slavenode.vm.box = "ubuntu/jammy64"
    slavenode.vm.hostname = "slavenode"
    slavenode.vm.network "private_network", ip: "192.168.56.20"
    slavenode.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1000"
    end
  end
end 