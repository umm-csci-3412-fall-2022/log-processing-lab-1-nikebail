#!/bin/bash

for file in "$1"/var/log/*
do
	awk 'match($0, /(\w{3}) {1,2}(\S+) (\w+):.+? Failed password .{1,16} (\S+) from (\S+)/, failedLoginData) {print failedLoginData[1] " " failedLoginData[2] " " failedLoginData[3] " " failedLoginData[4] " " failedLoginData[5]}' < "$file" >> "$1"/failed_login_data.txt
done
