# Nomad & Consul Connect demo stack

The simplest way to get a fully working Nomad with Consul Cluster.

## Requirements

- virtualbox
- vagrant

This project uses Ansible but __you don't need it on your host__ : it's installed on a VM by Vagrant and provisions everything from there.

## Run

```
vagrant up
```

That's it ! Have a cup of coffee while looking at Vagrant upping the VMs and setting everything for you.


## Setup Consul
copy / paste `consul-files/` content on the CI VM then

(start with the `*-defaults` files

```
consul config write <each file> 
```

## Setup Nomad
copy / paste `nomad-files/` content on the CI VM then

```
nomad run <each file> 
```

## Nota Bene

Due to a [current issue](https://github.com/hashicorp/nomad/issues/6459) in Nomad, upgrading the Connect stanza of a job needs to do 

```
nomad job stop <nameOfTheJob>
nomad run ./job.hcl
```
