#!/bin/bash

# # Aufgabe 1
# echo "Shell Scripting is fun!"

# # Aufgabe 2
# message="Shell Scripting is fun!"
# echo $message

# # Aufgabe 3
# hostname=`hostname`
# echo "Dieses Skript läuft auf $hostname."

# # Aufgabe 4
# file="file_path"
# if [ -f $file ]; then
#     echo "$file passwords are enabled"
# fi

# if [ -w $file ]; then
#     echo "Sie haben die Berechtungen, $file zu bearbeiten"
# else
#     echo "Sie haben keine Berechtungen, $file zu bearbeiten"
# fi

# # Aufgabe 5
# printf "Mensch\nBär\nSchwein\nHund\nKatze\nSchaf"

# Aufgabe 6
# echo "Enter file/directory name:"
# read file1
# if [[ -d $file1 ]]|| [[ -f $file1 ]]; then
#     file $file1
# else 
#     echo "there is no file/dir named $file1"
# fi

# Aufgabe 7
# if [[ -d $file1 ]]|| [[ -f $file1 ]]; then
#     file $file1
# else 
#     echo "there is no file/dir named $1"
# fi

# Aufgabe 8
# for var in "$@"
# do
#     if [[ -d $var ]]||[[ -f $var ]]; then
#         file $var
#     else 
#         echo "there is no file/dir named $var"
#     fi
# done

# Aufgabe 9
echo "Dieses Skript wird mit dem Exit-Status 0 beendet."
exit 0
