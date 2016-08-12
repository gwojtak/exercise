# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # config.vm.box = "CentOS-7-x86_64-Vagrant-1607_01.VirtualBox.box"
  config.vm.box = "centos/7"

  # This is to work around a bug in the current version of vagrant addressed in
  # https://github.com/mitchellh/vagrant/pull/7639
  config.ssh.insert_key = false

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8042, host: 8042
  config.vm.network "forwarded_port", guest: 8088, host: 8088
  config.vm.network "forwarded_port", guest: 19888, host: 19888
  config.vm.network "forwarded_port", guest: 50070, host: 50070
  config.vm.network "forwarded_port", guest: 50075, host: 50075

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network", bridge: "en3: USB Ethernet"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.synced_folder "/srv/salt/", "/srv/salt/"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
 
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #

  # Ensure we are completely up2date and have all
  # dependencies (EPEL repo, etc)
  config.vm.provision "shell", inline: <<-EOT
    yum -y update
    yum -y localinstall https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
    yum -y install systemd-python salt-minion
    systemctl enable salt-minion
    systemctl start salt-minion
    touch /.configure-hadoop
    mkdir /srv
    cp -r /vagrant/salt /srv/
  EOT

  config.vm.provision :salt do |salt|
    salt.minion_key = "salt-configs/exercise.pem"
    salt.minion_pub = "salt-configs/exercise.pub"
    salt.minion_config = "salt-configs/minion"
    salt.masterless = true
    salt.run_highstate = true
  end


end
