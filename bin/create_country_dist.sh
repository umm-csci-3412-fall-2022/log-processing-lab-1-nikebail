#!/bin/bash

#iterate through all versions of failed_login_data in the subdirectories of the main directory (represented by $1)
for file in "$1"/*/failed_login_data.txt
do
	awk 'match($0, /([0-9]+\..+)/, names) {print names[1]}' < "$file" >> temp.txt
done

# Sort the IP addresses numerically 0-9
sort temp.txt > sorted_temp.txt

# Get the correct country codes for each IP address
# Should create a file where each line is number of occurences of
# that an IP adress, followed by the IP address and then the country code
join sorted_temp.txt etc/country_IP_map.txt > country_ip.txt

awk 'match($0, / (\w{2})/, countries) {print "\047" countries[1] "\047"}' < country_ip.txt >> country_codes.txt

sort country_codes.txt  > country_codes_sorted.txt

# Counts the occurence of each IP address
# So we should get lines of an IP address followed by the country code
# Both of which preceded by the number of occurences that occer
uniq -c country_codes_sorted.txt > freq_countries.txt

awk 'match($0, /\s+(\S+) (\S+)/, data) {print "data.addRow([" data[2] ", " data[1] "]);"}' < freq_countries.txt >> content.txt


# Wrap the data in the HTML header/footers
./bin/wrap_contents.sh content.txt html_components/country_dist country_dist.html
mv country_dist.html data

# Cleaning up any temp files
rm country_codes_sorted.txt
rm country_codes.txt
rm freq_countries.txt
rm temp.txt
rm sorted_temp.txt
rm content.txt
rm country_ip.txt
