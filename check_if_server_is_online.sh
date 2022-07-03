#!/bin/bash
logging=false

ping $1 -c 1
if [ $? -eq 0 ]; then
    if "$logging" = true; then
        echo "server is online" > log.txt
    fi
    echo "server is online"
else
    if "$logging" = true; then
        echo "server is offline" > log.txt
    fi
    echo "server is offline"
fi