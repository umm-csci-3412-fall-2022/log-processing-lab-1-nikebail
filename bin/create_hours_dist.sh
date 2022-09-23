#!/bin/bash

#iterate through all versions of failed_login_data in the subdirectories of the main directory (represented by $1)
for file in "$1"/*/failed_login_data.txt
do
	awk 'match($0, /\w \w+ (\w+)/, hours) {print "\047" hours[1] "\047"}' < "$file" >> temp.txt
done

# Sorts hours for uniq
sort temp.txt > sorted_temp.txt

# Writes frequency of login times to a temp file
uniq -c sorted_temp.txt >> freq_hour.txt

# Extracts the hour  of failed login attempts temp file, formats the data as a javaScript method call, writes output to another temp file
while read -r line
do
echo "$line" > super_temp_file.txt
	awk 'match($0, /(\S+) (\S+)/, hour_freq) {print "data.addRow([" hour_freq[2] ", " hour_freq[1] "]);"}' < super_temp_file.txt >> content.txt
done < freq_hour.txt

# Wrap the data in the HTML header/footers 
./bin/wrap_contents.sh content.txt html_components/hours_dist hours_dist.html
mv hours_dist.html data

# Clean up temp files!
rm content.txt
rm temp.txt
rm sorted_temp.txt
rm freq_hour.txt
rm super_temp_file.txt
