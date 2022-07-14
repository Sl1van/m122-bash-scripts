#!/bin/bash
./unzipper3003.sh vollsicher.zip &
threepid=$?
./unzipper3004.sh vollsicher.zip &
fourpid=$?
./unzipper3005.sh vollsicher.zip &
fivepid=$?

while(true); do
    echo "test"
    if test -f "./password"; then
        echo "the password of the cracked file is:"
        cat ./password
        rm -f ./password
        kill $threepid
        kill $fourpid
        kill $fivepid
        exit 0;
    fi
    if ! ps -p $threepid > /dev/null
    then
        if ! ps -p $fourpid > /dev/null
        then
            if ! ps -p $fivepid > /dev/null
                then
                if ! test -f "./password"; then
                    echo "the password of the password protected file could not be found out"
                    exit 1;
                fi
            fi
        fi
    fi
    sleep 2
done