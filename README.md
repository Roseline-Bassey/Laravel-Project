# Laravel-Project

## The objective of this project is to:
- Automate the provisioning of two Ubuntu-based servers, named "Master" and "Slave", using Vagrant.
- Create a bash script to automate the deployment of a LAMP (Linux, Apache, MySQL, PHP) stack on the Master node.
- Clone a PHP application from GitHub, install all necessary packages, and configure Apache web server and MySQL using the same bash script, i.e the `lampstack.sh`

## Prerequisite
- Vagrant
- Virtualbox
- Laravel app
- Ansible

## Setting up the two Ubuntu-based servers.
After installing both Vagrant and Virtualbox. Run the`vagrant init` command to initialize a new `Vagrantfile` in your project's root directory. Check `Vagrantfile` For a sample syntaxs for automating two servers. Next, run the `vagrant up` command to provision your servers. Once successful you'll have two servers in a `running` state on your Virtualbox.

![Ubuntu-servers](<images/Screenshot 2023-10-31 100045.png>)

## A. MasterNode

The masternode act as the controller while the slavenode is the target machine. On the `Vagrantfile` there's a `masternode` section, under which I have specified a path to a bashscript to automate the setup of LAMPSTACK and other configurations requried to serve the laravel application on the masternode server. 








