#!/bin/bash

cd $1
here=$(pwd)

for file in $here/var/log/*
do
echo "$file"
	awk 'match($0, /(\w{3}) (\S+) (\w+):.+? Failed password for.+? (\S+) from (\S+)/, failedLoginData) {print failedLoginData[1] " " failedLoginData[2] " " failedLoginData[3] " " failedLoginData[4] " " failedLoginData[5]}' < "$file" >> failed_login_data.txt
done
