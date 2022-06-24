#!/bin/bash
# Kommentieren Sie die Zeilen aus die sie ausführen wollen.

#Aufgabe1
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

# #Aufgabe2
# grep -a -w "^2" $1 > $2

# #Aufgabe3
# grep -a -w "^2" $1 | grep -a -v -w "^2\t26" > $2

# #Aufgabe4
# grep -a -w "^2" $1 | grep -a -v -w "^2\t26" | cut -f3-4 > $2

# #Aufgabe5
# # I have no idea why this doesn't work  grep -a -w "^2" $1 | grep -a -v -w "^2\t26" | cut -f3-4 | grep -a -v -w "\w\d{7}" > $2
# grep -a -w "^2" $1 | grep -a -v -w "^2\t26" | cut -f3-4 | grep -a -v "[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" > $2