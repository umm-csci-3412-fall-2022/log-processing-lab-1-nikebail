#!/bin/bash
currentdir=$(pwd)
tempdir="/tmp/logs_processing_temp"
mkdir -p -v "$tempdir"
for var in "$@"
do  
	workingdir="$tempdir"/"${var%.*}"
	mkdir -p -v "$workingdir"
	tar -xf "$var" --directory "$workingdir"
	./bin/process_client_logs.sh "$workingdir"
done
./bin/create_username_dist.sh "$tempdir"
./bin/create_hours_dist.sh "$tempdir"
./bin/create_country_dist.sh "$tempdir"

./bin/assemble_report.sh "$tempdir"

mv failed_login_summary.html "$currentdir" 
