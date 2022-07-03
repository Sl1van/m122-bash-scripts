#!/bin/bash

zip -r backup.zip $1

today=date+'%m/%d/%Y'
scp remote_username@10.10.0.2:/backups/$today.txt backup.zip
