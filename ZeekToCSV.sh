#!/bin/bash


FILEPATH=/"path_to_the_input_logs_directory"/ #path to input logs directory 
OUTPATH=/"path_to_the_output_logs_directory"/ #path to output logs directory

echo "Transforming to csv ..."
for log in $(ls $FILEPATH); do

	FILEIN=$FILEPATH$log
	FILEOUT=$OUTPATH$log

	# -d option in zeek-cut convert time values into 
	# human-readable format. %Y-%m-%dTH%:%M:%S
	cat $FILEIN | zeek-cut -c -d > $FILEOUT
	
	# If you don´t want to use zeek-cut, comment the line above
	# and uncomment the line below
	#sed -i '$d' $FILEOUT

	# Remove line 8
	sed -i '8d' $FILEOUT

	# Remove lines 1 to 6
	sed -i '1,6d' $FILEOUT

	# Delete #fields
	sed -i 's/#fields\t//' $FILEOUT

	# Replace '\t' with ','
	sed -i 's/\t/,/g' $FILEOUT
done
echo "Done"
