#!/bin/sh

echo "${1}"

nomad job stop -purge "${1}"

nomad run "${1}".hcl

# jobs=( statsd jaeger prometheus ingress fake echo1 echo2 )

# for job in "${jobs[@]}"
# do
#   echo "${job}"
#   nomad job stop -purge "${job}"
#   nomad run "${job}".hcl
#   # do something on $var
# done
