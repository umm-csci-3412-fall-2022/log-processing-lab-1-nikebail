#!/bin/bash

# concatenate the contents of the three distributions
cat "$1"/country_dist.html "$1"/hours_dist.html "$1"/username_dist.html > temp.txt

#wraps distributions in the overall header/footer for the final webpage
./bin/wrap_contents.sh temp.txt html_components/summary_plots failed_login_summary.html

#moves to data :D 
mv failed_login_summary.html data 
