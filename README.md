# Custom Vagrant V8 Setup

This guide is for setting up a frappe/erpnext vagrant box from scratch plus a few extra productivity goodies.

Make sure you have vagrant installed and virtual box:

https://www.vagrantup.com/

https://www.virtualbox.org/

info about vagrant and virtualbox:

https://www.vagrantup.com/docs/virtualbox/

## Creating vagrant box.

### Steps

1) Clone this repo somewhere in your host machine, open a terminal and cd into the directory.

2) Kick off vagrant box setup:
```bash
   vagrant up
```

3) Go make some coffee, this will take a while

to create a test frappe site

bench new-site frappe

## Starting the dev instance of frappe

bench start

## Mounting apps directory for ease of development

You can use vagrant's file system sync feature to edit your apps in your host and making these changes immediately available to the frappe guest vm.

### Steps

After you have built and initialized your vagrant box:

1) Start up your vagrant box and ssh into it
```bash
   vagrant up
   vagrant ssh
```

2) Move the apps directory in ~/frappe-bench/apps to your vagrant shared directory /vagrant/ and create mount point
```bash
   mv ~/frappe-bench/apps /vagrant/
   mkdir ~/frappe-bench/apps
```

3) Edit ~/.profile add the following lines at the end of the file
```bash
   sudo mount --bind /vagrant/apps /home/vagrant/frappe-bench/apps
```

4) Execute changes to .profil
```bash
   source ~/.profile
```

Your vagrant/apps folder now can be used on your host as well as guest without having to manualy syncronize any data

## Proxy your frappe guest through your host's nginx

You can proxy your development frappe instance through your local nginx server to ease development through a custom local hostname or even make your local development instance available to the internet.

Make sure your instance is accessive first through:

http://127.0.0.1:8002

### Macos

#### Steps

1) Copy mac-nginx/conf.d/frappe-v8.conf to your local nginx config file
```bash
   cp ./mac-nginx/conf.d/frappe-v8.conf /usr/local/etc/nginx/conf.d/
```

2) Edit your newly copied nginx config file and change the domain name to anything you like.
```bash
   server_name frappev8.dev;
```
   to
```bash
   server_name myfrappe.dev;
```

3) Edit your /etc/hosts file to point to your local nginx instance
```bash
   127.0.0.1  frappev8.dev
```
   or if you changed your domain
```bash
   127.0.0.1  myfrappe.dev
```

4) Start nginx
```bash
   sudo nginx
```
   or reload it if already running
```bash
   sudo nginx -s reload
```

5) Now you can access your dev frappe instace on your browser at:
```bash
   http://frappev8.dev
```
   or if you changed your domain
```bash
   http://myfrappe.dev
```

