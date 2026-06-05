#!/bin/bash

tag=$(timew 2>/dev/null | awk '/^Tracking/ {print $2}')
if [[ -z "$tag" ]]; then
    exit 0
fi
time=$(timew | awk '/^ *Total/ {print $NF}')
echo "$tag $time"
