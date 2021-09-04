#!/bin/bash

FILEPATH=// #path to input logs directory 
OUTPATH=// #path to output logs directory

echo "Transforming to csv ..."
for log in $(ls $FILEPATH); do

	FILEIN=$FILEPATH$log
	FILEOUT=$OUTPATH$log
	
	# Removing all headers and changing timestamp format
	cat $FILEIN | zeek-cut -D "%Y-%m-%d %H:%M:%S" > $FILEOUT
	
	# Change existing commas to spaces so there is no missundertud
	# when transforming to csv
	sed -i 's/,/ /g' $FILEOUT
	
	#Changing tabs to commas
	sed -i 's/\t/,/g' $FILEOUT
	
done
echo "Done"
