#!/bin/bash

#iterate through all versions of failed_login_data in the subdirectories of the main directory (represented by $1)
for file in "$1"/*/failed_login_data.txt
do
echo "$file"
	awk 'match($0, /([0-9]+\..+)/, names) {print "\047" names[1] "\047"}' < "$file" >> temp.txt
done

# Sort the IP addresses numerically 0-9
sort temp.txt > sorted_temp.txt

# Get the correct country codes for each IP address
# Should create a file where each line is number of occurences of
# that an IP adress, followed by the IP address and then the country code
join sorted_temp.txt etc/country_IP_map.txt > country_IP.txt

# Counts the occurence of each IP address
# So we should get lines of an IP address followed by the country code
# Both of which preceded by the number of occurences that occer
uniq -c country_IP.txt >> freq_countries.txt


# Wrap the data in the HTML header/footers
./bin/wrap_contents.sh content.txt html_components/country_dist country_dist.html
mv country_dist.html data

# Cleaning up any temp files
rm temp.txt
rm sorted_temp.txt
rm country_IP.txt
