#!/bin/bash
# Kommentieren Sie die Zeilen aus die sie ausführen wollen.

# Aufgabe 17
# Aufgabe 18

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