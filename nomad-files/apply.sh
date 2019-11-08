#!/bin/bash

job_name_from_file='\.\/(.*)\.hcl'

if [[ $1 == "all" ]]
then
    echo "applying all"
    for file in ./*
    do
        if [[ -f $file && $file =~ $job_name_from_file ]]; then
            job="${BASH_REMATCH[1]}"
            nomad job stop -purge "$job"
            nomad run "$job".hcl
        fi
    done
else
    echo "applying $1"

    if [[ $1 =~ $job_name_from_file ]]; then
        job="${BASH_REMATCH[1]}"
        nomad job stop -purge "$job"
        nomad run "$job".hcl
    fi
fi
