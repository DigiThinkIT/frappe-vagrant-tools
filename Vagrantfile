# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.auto_update=false
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "forwarded_port", guest: 8000, host: 8002
  config.vm.network "forwarded_port", guest: 9000, host: 9002
  config.vm.network "forwarded_port", guest: 6787, host: 6787

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant", fsnotify: [:modified, :removed], exclude: ["*.pyc", "*.pyd", "*.pyo", ".git/*"]
  config.trigger.after :up do run "vagrant fsnotify" end

  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true
     # Customize the amount of memory on the VM:
     vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Updating..."
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get -y upgrade
    apt install python2.7
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo "Install Bench"
    cp /vagrant/install.py /tmp/
    cd /tmp
    sudo rm ~/.wget-hsts
    python install.py --develop --password="frappe"

    source /vagrant/post_install.sh
  SHELL
end
