#!/bin/bash

items=(
    "altair"
    "betelgeuse"
    "canopus"
)

for item in "${items[@]}" ; do
    echo "[ ${item} ]"
done
