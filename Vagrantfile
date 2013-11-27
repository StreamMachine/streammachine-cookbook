# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "streammachine"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "canonical-ubuntu-12.04"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  
  config.omnibus.chef_version = :latest

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "192.168.133.25"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = "./data_bags"
    
    chef.json = {
      nodejs: { install_method: "package" }
    }

    chef.run_list = [
        "recipe[streammachine::install_redis]",
        "recipe[streammachine]"
    ]
  end
end
