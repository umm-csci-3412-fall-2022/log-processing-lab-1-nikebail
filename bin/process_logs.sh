#!/bin/bash

# saves current directory in variable 
currentdir=$(pwd)

# creates temp directory for processing 
tempdir="/tmp/logs_processing_temp"
mkdir data
mkdir -p "$tempdir"

# iterates through all arguments, unzips them into their own directory within the tempdirectory, generates failed_login_data using process_client_logs.sh
for var in "$@"
do  
	workingdir="$tempdir"/"${var%.*}"
	mkdir -p "$workingdir"
	tar -xf "$var" --directory "$workingdir"
	./bin/process_client_logs.sh "$workingdir"
done

processed_logs="$tempdir"/log_files

# runs our three processing scripts on the failed login data
./bin/create_username_dist.sh "$processed_logs"
./bin/create_hours_dist.sh "$processed_logs"
./bin/create_country_dist.sh "$processed_logs"

# assembles all the html files into a final webpage
./bin/assemble_report.sh "$currentdir"/data

# moves back into the directory in which the script was called
mv data/failed_login_summary.html "$currentdir"

# Clean up: removes temp directory
rm -rf "$tempdir"
