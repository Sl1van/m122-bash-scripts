#!/bin/bash
# Kommentieren Sie die Zeilen aus die sie ausführen wollen.

# # Aufgabe 17
# rand=$((RANDOM%100))
# echo $rand
# echo $rand | logger -p user.info

# # Aufgabe 18
# function random_number {
#   rand=$((RANDOM % 100))
#   echo $rand
#   logger -p user.info -i -t randomly $rand
# }
# random_number
# random_number
# random_number

# # Aufgabe 19
# function executeCommandAndExitOnError {
#     echo "trying to execute the following command: $1"
#     eval "$1"
#     if [ $? -eq 0 ]; then
#         echo "command exited with error"
#         exit 1
#     else
#         echo "command executed successfully"
#     fi
# }

# executeCommandAndExitOnError "ls ."
# executeCommandAndExitOnError "ls -imgonnathrowanerror ."
# executeCommandAndExitOnError "ls -la ."

# # Aufgabe 20
# function executeCommandAndExitOnError {
#     echo "trying to execute the following command: $1"
#     eval "$1"
#     if [ $? -eq 0 ]; then
#         echo "command exited with error"
#     else
#         echo "command executed successfully"
#     fi
# }

# executeCommandAndExitOnError "ls ."
# executeCommandAndExitOnError "ls -imgonnathrowanerror ."
# executeCommandAndExitOnError "ls -la ."