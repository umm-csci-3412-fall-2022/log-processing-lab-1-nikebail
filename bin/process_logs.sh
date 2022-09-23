#!/bin/bash
currentdir=$(pwd)
tempdir="/tmp/logs_processing_temp"
mkdir data
mkdir -p "$tempdir"
for var in "$@"
do  
	workingdir="$tempdir"/"${var%.*}"
	mkdir -p "$workingdir"
	tar -xf "$var" --directory "$workingdir"
	./bin/process_client_logs.sh "$workingdir"
done
ls "$tempdir"/log_files/zeus_secure
processed_logs="$tempdir"/log_files
./bin/create_username_dist.sh "$processed_logs"
./bin/create_hours_dist.sh "$processed_logs"
./bin/create_country_dist.sh "$processed_logs"

./bin/assemble_report.sh "$currentdir"/data

mv data/failed_login_summary.html "$currentdir"

rm -rf "$tempdir"
