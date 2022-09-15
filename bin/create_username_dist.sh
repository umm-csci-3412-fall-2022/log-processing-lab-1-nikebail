#!/bin/bash
for file in "$1"/*/failed_login_data.txt
do
echo "$file"
	awk 'match($0, /\w{3} {1,2}\S+ \w+ (\w+)/, names) {print "\047" names[1] "\047"}' < "$file" >> temp.txt
done
sort temp.txt > sorted_temp.txt
uniq -c sorted_temp.txt >> freq_name.txt
rm temp.txt
while read line
do
echo "$line" > super_temp_file.txt
	awk 'match($0, /(\d+) (\S+)/, name_freq) {print "data.addRow([" name_freq[2] ", " name_freq[1] "]);"}' < super_temp_file.txt >> content.html
done < freq_name.txt
./bin/wrap_contents.sh content.html html_components/username_dist username_dist.html
