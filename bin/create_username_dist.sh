#!/bin/bash

#iterate through all versions of failed_login_data in the subdirectories of the main directory (represented by $1)
for file in "$1"/*/failed_login_data.txt
do
	awk 'match($0, /\w{3} {1,2}\S+ \w+ (\S+)/, names) {print "\047" names[1] "\047"}' < "$file" >> temp.txt
done

# Sorts names for uniq
sort temp.txt > sorted_temp.txt

# Writes usernames/number of failed login attempts to a temp file
uniq -c sorted_temp.txt >> freq_name.txt

# Extract names/number of failed login attempts temp file, formats the data as a javaScript method call, writes output to another temp file
while read -r line
do
echo "$line" > super_temp_file.txt
	awk 'match($0, /(\S+) (\S+)/, name_freq) {print "data.addRow([" name_freq[2] ", " name_freq[1] "]);"}' < super_temp_file.txt >> content.txt
done < freq_name.txt

# Wrap the data in the HTML header/footers
./bin/wrap_contents.sh content.txt html_components/username_dist username_dist.html
mv username_dist.html data

rm content.txt
rm temp.txt
rm sorted_temp.txt
rm freq_name.txt
rm super_temp_file.txt
