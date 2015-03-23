# -*- mode: ruby -*-
# vi: set ft=ruby :
require "etc"

$start_zsh = <<SCRIPT
echo Changing to zsh
sudo chsh -s $(which zsh) $(whoami)
SCRIPT

# Must install oh-my-zsh by hand
# Use sudo chsh -s $(which zsh) $(whoami)
# Then restart session

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = false
  
  # config.nfs.map_uid = Process.uid
  # config.nfs.map_gid = Process.gid
  # config.vm.synced_folder ENV['PROJECT_DIR'], ENV['VAGRANT_PROJECT_DIR'], nfs: true

  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 3000, host: 3000


  # config.vm.define :devbox do |v|
  #   v.vm.hostname = ENV['HOSTNAME']
  #   v.vm.network :private_network, ip: server_ip
  # end

  config.vm.hostname = "imhotep-dev-host"
  config.vm.network :private_network, ip: "192.168.10.101"
  config.vm.synced_folder ".", "/home/vagrant/imhotep-dev", 
                              id: "core",
                              :nfs => true,
                              :mount_options => ['nolock,vers=3,udp,noatime']

  config.vm.provider :virtualbox do |vbox|
      # vbox.name = "gogobot-devbox"
      vbox.customize ["modifyvm", :id, "--memory", 6114]
      vbox.customize ["modifyvm", :id, "--cpus", 2]
      vbox.customize ["modifyvm", :id, "--cpuhotplug", "on"]
      vbox.customize ["modifyvm", :id, "--cpuexecutioncap", 85]
      vbox.customize ["modifyvm", :id, "--pae", "on"]
      vbox.customize ["modifyvm", :id, "--ioapic", "on"]
      vbox.customize ["modifyvm", :id, "--acpi", "off"]
      vbox.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vbox.customize ["modifyvm", :id, "--vrde", "off"]
      vbox.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", "1"]
  end

  config.vm.provision :shell do |shell|
    shell.inline = "touch $1 && chmod 0440 $1 && echo $2 > $1"
    shell.args = %q{/etc/sudoers.d/root_ssh_agent "Defaults    env_keep += \"SSH_AUTH_SOCK\""}
  end

# Running Setup
  config.vm.provision "shell", path: "scripts/setup.sh"

# Install Ruby and Rails
  config.vm.provision "shell", path: "scripts/railsready/railsready-rvm.sh"

# Install Nodejs
  # config.vm.provision "shell", path: "scripts/nodejs.sh", privileged: false

# Switch to zsh
  # config.vm.provision "shell", inline: $start_zsh

# Install OH-My-ZSH
  # config.vm.provision "shell", path: "scripts/oh-my-zsh5.sh"

# launch all the docker containers as part of provisioning
  # config.vm.provision "shell", inline: "cd imhotep-dev && fig up -d"

end