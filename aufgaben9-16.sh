#!/bin/bash
# Kommentieren Sie die Zeilen aus die sie ausführen wollen.

# # Aufgabe 9
# echo "Dieses Skript wird mit dem Exit-Status 0 beendet."
# exit 0

# # Aufgabe 11
# cat /etc/shadow
# if [ $? -eq 0 ]; then
#     echo "command succeeded: $?"
#     exit 0
# else
#     echo "command failed"
#     exit 1
# fi

# # Aufgabe 10
# for var in $@; do
#   if [ -f $var ]; then
#     echo "exiting with status 0"
#     exit 0
#   elif [ -d $var ]; then
#     echo "exiting with status 1"
#     exit 1
#   else
#     echo "exiting with status 2"
#     exit 2
#   fi
# done

# # Aufgabe 12
# countFiles() {
#     ls -1q $1 | wc -l
# }

# countFiles '.'

# # Aufgabe 13
# listFiles() {
#     printf $1:
#     ls -1q $1 | wc -l
# }

# listFiles '/etc'
# listFiles '/var'
# listFiles '/usr/bin'

# # Aufgabe 14
# function rename_files {
#   for file in ; do
#     if [ -f $file ]; then
#       if [[ $file ==.jpg ]]; then
#         new_name=$(date +%Y-%m-%d)-$file
#         echo $new_name
#         # mv $file $new_name
#       fi
#     fi
#   done
# }

# rename_files
# # Aufgabe 15
# function rename_files_custom {
#   for file in *; do
#     if [ -f $file ]; then
#       if [[ $file == *$1 ]]; then
#         if [ -z $2 ]; then
#           new_name=$(date +%Y-%m-%d)-$file
#           mv $file $new_name
#         else
#           new_name=$2-$file
#           mv $file $new_name
#         fi
#       fi
#     fi
#   done
# }
# echo "Please enter a file extension"
# read extension
# echo "Please enter a custom prefix or leave empty"
# read prefix
# rename_files_custom $extension $prefix

# Aufgabe 16
# echo "Please enter a command"
# read command
# $command &
# echo "Press enter to kill process"
# read xyz
# kill $!
