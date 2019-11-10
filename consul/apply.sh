#!/bin/sh

# consul
for file in ./proxy-defaults/*; do consul config write $file; done
for file in ./service-defaults/*; do consul config write $file; done
for file in ./service-router/*; do consul config write $file; done
for file in ./service-splitter/*; do consul config write $file; done
