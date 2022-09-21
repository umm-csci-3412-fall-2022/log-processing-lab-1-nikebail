#!/bin/bash

#iterate through all versions of failed_login_data in the subdirectories of the main directory (represented by $1)
for file in "$1"/*/failed_login_data.txt
do
echo "$file"
	awk 'match($0, /([0-9]+\..+)/, names) {print "\047" names[1] "\047"}' < "$file" >> temp.txt
done

# Wrap the data in the HTML header/footers
./bin/wrap_contents.sh content.txt html_components/username_dist username_dist.html
mv username_dist.html data
