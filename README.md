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


## Setup Nomad & Consul services 
```
vagrant ssh ci
./apply.sh
```

### check

__Nomad__ : 

open [http://172.16.2.10:4646](http://172.16.2.10:4646)

__Prometheus__ :

```
ssh -L localhost:9090:localhost:9090 -i ./.vagrant/machines/monitoring/virtualbox/private_key vagrant@172.16.2.10
``` 

then  [http://localhost:9090](http://localhost:9090)

__App__ :

```
curl 172.16.1.10:8080
"==> echo 1"

curl 172.16.1.10:8080/v2
"==> echo 2"
```

## Nota Bene

Due to a [current issue](https://github.com/hashicorp/nomad/issues/6459) in Nomad, upgrading the Connect stanza of a job needs to do 

```
nomad job stop <nameOfTheJob>
nomad run ./job.hcl
```
