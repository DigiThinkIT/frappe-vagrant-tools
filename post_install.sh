#!/bin/bash

# comment the 'exit 0' line if you want to move ~/frappe-bench/apps to /vagrant/apps to share codebase over vagrant shared folders.
# Notice that there are issues with inotify where edited file events will not cross from host to guest unless you setup something yourself
# see vagrant-fsinotify plugin for more info

#exit 0

mv ~/frappe-bench/apps /vagrant/apps
mkdir -p ~/frappe-bench/apps

echo -e "\nmount --bind /vagrant/apps /home/vagrant/frappe-bench/apps\n" >> ~/.profile
