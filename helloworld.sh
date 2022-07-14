#!/bin/bash

echo "Hello world"
printf "\n\n"

for i in {1..100}
do
   echo "Hello world $i times"
done

printf "\n\n"

mins=$(date +"%M")
for (( min=1; min<=mins; min++ ))
do
   echo "Hello world $min times"
done