#!/bin/bash
for file in "$1"/*/failed_login_data.txt
do
echo "$file"
	awk 'match($0, /\w{3} {1,2}\S+ \w+ (\w+)/, names) {print "\047" names[1] "\047"}' < "$file" >> "$1"/temp.txt
done
sort temp.txt > sorted_temp.txt
uniq -c sorted_temp.txt
rm temp.txt
while read line
do
	awk 'match($0, /(\d+) (\w+)/, name_freq) {print "data.addRow([" name_freq[2] ", " name_freq[1] "]);"}' < "$line" >> content.html
done < sorted_temp.txt
./bin/wrap_contents.sh content.html html_components/username_dist username_dist.html
