#! usr/bin/bash
mkdir tempdir
for var in "$@"
do 
	tar -xf "$var" -C /tempdir
	./bin/process_client_logs.sh ./tempdir/
done

 
