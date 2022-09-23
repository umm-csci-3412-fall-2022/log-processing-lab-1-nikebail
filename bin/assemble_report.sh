#!/bin/bash
cat "$1"/country_dist.html "$1"/hours_dist.html "$1"/username_dist.html > temp.txt
./bin/wrap_contents.sh temp.txt html_components/summary_plots failed_login_summary.html
mv failed_login_summary.html data 
