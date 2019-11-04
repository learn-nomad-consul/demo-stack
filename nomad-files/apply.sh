#!/bin/bash

if [ $1 == "all" ]
then
    echo "applying all jobs"
    for job in statsd jaeger prometheus ingress echo1 echo2 chaos
    do
        nomad job stop -purge "$job"
        nomad run "$job".hcl
     done
else
    echo "applying $1"
    nomad job stop -purge "$1"
    nomad run "$1".hcl
fi
