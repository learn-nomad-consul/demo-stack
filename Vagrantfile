# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_version = "20191113.0.0"

  if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--audio", "none"]
  end

  config.vm.define "ctrlplane" do |c|
    c.vm.hostname = "ctrlplane"
    c.vm.network "private_network", ip: "172.16.1.9"
    c.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "ingress" do |c|
    c.vm.hostname = "ingress"
    c.vm.network "private_network", ip: "172.16.1.10"
    c.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "dataplane" do |c|
    c.vm.hostname = "dataplane"
    c.vm.network "private_network", ip: "172.16.1.11"
    c.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "monitoring" do |c|
    c.vm.hostname = "monitoring"
    c.vm.network "private_network", ip: "172.16.2.10"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.synced_folder "./grafana/", "/home/vagrant/grafana"
  end

  config.vm.define "ci" do |c|
    c.vm.hostname = "ci"
    c.vm.network "private_network", ip: "172.16.2.11"
    c.vm.synced_folder ".", "/vagrant", disabled: true
    c.vm.synced_folder "./nomad/", "/home/vagrant/nomad"
    c.vm.synced_folder "./consul/", "/home/vagrant/consul"
  end

  config.vm.define 'controller' do |machine|
    machine.vm.network "private_network", ip: "172.16.3.10"

    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "/vagrant/ansible/main.yml"
      ansible.install        = true
      ansible.limit          = "all"
      ansible.verbose        = true
      ansible.inventory_path = "/vagrant/ansible/inventory"
    end
  end

end
