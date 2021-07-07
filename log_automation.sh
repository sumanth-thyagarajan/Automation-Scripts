#!/bin/bash

if [ “$1” == “” ]
then
	echo Error executing automation script: Missing log file location
	echo Syntax: ./log_automation.sh loglocation
	echo Exmaple: ./log_automation.sh /home/user/log_location
else
	echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       	echo "+             	    File Zip Automation  	                 +"
	echo "+                                  -by Sumanth         	         +"
	echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	echo -e "\n"
	
	DIR=/tmp/log_files

	if [ -d "$DIR" ] ; then 
		rm -rf /tmp/log_files
	fi
	
	mkdir /tmp/log_files
	
	echo [+] Finding  all the log files created in last 7 days	
	find $1 -name "*.tar.gz" -type f -mtime -7  -exec ls -l {} \; | sort | cut -d ' ' -f 10 > /tmp/log_files/file.txt
	
	echo [+] /tmp/log_files/file.txt contains log file name list
	FILENAME="/tmp/log_files/file.txt"
	
	cd /tmp/log_files
	for line in $(cat $FILENAME)
	do
		tar -zxf $line
		echo [+] Unzipped $line file
	done
	echo [-] Deleting log file name list
	rm file.txt
	
	UNZIPPED_FILES=$(ls)
	tar -czf archived_logs.tar.gz $UNZIPPED_FILES
	echo [+} Compressed logs can be found in archived_logs.tar.gz file
	rm *.txt	
fi
