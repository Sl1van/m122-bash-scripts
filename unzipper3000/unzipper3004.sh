#!/bin/bash

for char1 in {a..z} {0..9} ; do
    for char2 in {a..z} {0..9} ; do
        for char3 in {a..z} {0..9} ; do
            for char4 in {a..z} {0..9} ; do
                unzip -oq -P "$char1$char2$char3$char4" vollsicher.zip
                if [ $? -eq 0 ]; then
                    touch ./password
                    echo "$char1$char2$char3$char4" > ./password
                    exit 0
                fi
            done
        done        
    done
done