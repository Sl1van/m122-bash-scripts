#!/bin/bash
path="."
currentTime=$(date +%Y%m%d_%H%M%S)    
log=$path
days=10

find $path -type f -mtime +$days -delete