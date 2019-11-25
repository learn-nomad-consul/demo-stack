# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-cloudinit"]

  # use the vagrant cloud box
  config.vm.box = "err0r500/bionic64-consul-nomad-tf"
  config.vm.box_version = "0.1"

  # use the local box
  # config.vm.box = "image/output-vagrant/package.box"
  # if Vagrant.has_plugin?("vagrant-vbguest")
  #     config.vbguest.auto_update = false
  # end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--audio", "none"]
  end

  config.vm.define "ctrlplane" do |c|
    c.vm.hostname = "ctrlplane"
    c.vm.network "private_network", ip: "172.16.1.9"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.provision :cloud_init, user_data: "./cloud-init/ctrlplane.yml"
  end

  config.vm.define "ingress" do |c|
    c.vm.hostname = "ingress"
    c.vm.network "private_network", ip: "172.16.1.10"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.provision :cloud_init, user_data: "./cloud-init/ingress.yml"
  end

  config.vm.define "dataplane" do |c|
    c.vm.hostname = "dataplane"
    c.vm.network "private_network", ip: "172.16.1.11"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.provision :cloud_init, user_data: "./cloud-init/dataplane.yml"
  end

  config.vm.define "monitoring" do |c|
    c.vm.hostname = "monitoring"
    c.vm.network "private_network", ip: "172.16.2.10"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.synced_folder "./grafana/", "/home/vagrant/grafana"
    c.vm.provision :cloud_init, user_data: "./cloud-init/monitoring.yml"
  end

  config.vm.define "ci" do |c|
    c.vm.hostname = "ci"
    c.vm.network "private_network", ip: "172.16.2.11"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.synced_folder "./nomad/", "/home/vagrant/nomad"
    c.vm.synced_folder "./consul/", "/home/vagrant/consul"
    c.vm.provision :cloud_init, user_data: "./cloud-init/ci.yml"
  end

  config.vm.define "nfs" do |c|
    c.vm.hostname = "nfs"
    c.vm.network "private_network", ip: "172.16.2.12"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.synced_folder "./nomad/", "/home/vagrant/nomad"
    c.vm.synced_folder "./consul/", "/home/vagrant/consul"
    c.vm.provision :cloud_init, user_data: "./cloud-init/nfs.yml"
  end 
end
