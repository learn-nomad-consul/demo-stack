#!/bin/sh

# consul
for file in ./consul-files/proxy-defaults/*; do consul config write $file; done
for file in ./consul-files/service-defaults/*; do consul config write $file; done
for file in ./consul-files/service-router/*; do consul config write $file; done

# nomad
for file in ./nomad-files/*; do nomad run $file; done
