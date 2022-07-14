#!/bin/bash

#check inputs and outputs
if [ -z $1 ]; then
    echo "input wasn't set exiting...";
    exit 1;
else
    echo "input was set";
fi

if [ -z $2 ]; then
    echo "output wasn't set exiting...";
    exit 1;
else
    echo "output was set";
fi

grep -a -w "^2" $1 | grep -a -v -w "^2\t26" | cut -f3-4 | grep -a -v "[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" > $2