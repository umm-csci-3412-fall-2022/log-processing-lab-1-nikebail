#!/bin/bash

cd $1
here=$(pwd)

for file in $here/var/log/*
do
echo "$file"
	awk 'match($0, /(\w{3}) (\S+) (\w+):\S+ (\w+?) .+? Failed password .+ from ([0-9.]+)/, failedLoginData) {print failedLoginData[1] " " failedLoginData[2] " " failedLoginData[3] " " failedLoginData[4] " " failedLoginData[5] "\n" }' < "$file" >> failed_login_data.txt
done
