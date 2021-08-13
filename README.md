# ZeekLogsToCSV
A simple Bash script made for transform Zeek logs into a csv (comma-separated values) format.
The operation of the script depends on the sed command, since making use of this command unnecessary lines will be removed and certain characters will be replaced.

## Line by line explanation
Take the image below as a reference of the structure of any zeek log file in its default format (tsv).

![alt text](https://github.com/fedemoles/ZeekLogsToCSV/blob/main/images/tsv_log.PNG)

Almost all lines in the header are not really of interest from an log analysis perspective, lines 1 to 6 and line 8 will be deleted.
Line 7 will be saved since it contains the fields name.
As the majority of the lines in the header, the last line will be removed.

The timestamp field is in a non human-readeble format, so the zeek-cut utility is used to transfor it in a human-readeble format.

All sed commands are inside a for loop. This loop goes through all the files within a directory, in such a way that by executing the script once, all the logs in the same directory will be transformed to csv.


```
cat $FILEIN | zeek-cut -c -d > $FILEOUT
```

-d option in the zeek-cut tool stands for changing the timestamp to a human-readeble format.
-c option is used for saving the header, but doesn´t save the last line, so it isn´t necesary delete the last line in another step.<br />
💡 If you don´t want to use zeek-cut (because you don´t have acces to it in your pc or you just don´t want to change the default time stamp format), comment the line above and uncomment the following line in the script in order to remove the last line that has not been removed by not using the -c option to zeek-cut.

```
# sed -i '$d' $FILEOUT
```

The line below is for removing the eighth line of the log (data type of each filed)

```
sed -i '8d' $FILEOUT
```

The following line deletes lines 1 to 6

```
sed -i '1,6d' $FILEOUT
```

In the previous image you can see that the line that indicates the names of the fields is preceded by "#fields \ t", so the line that appears below is to eliminate those characters

```
sed -i 's/#fields\t//' $FILEOUT
```

The last thing left to do is replace the tabs "\ t" with commas "," to go from tsv to csv

```
sed -i 's/\t/,/g' $FILEOUT
```


#### Final output

![alt text](https://github.com/fedemoles/ZeekLogsToCSV/blob/main/images/csv_log.PNG)

The image above show the final output once the script had been executed. It present a csv format saving only the fields names headers.


## Getting started

I guess if you landed in this repository, you would probably know how to clone or download the repository, but in case you don´t just follow the steps.

You can just download a ZIP with all the files in the repository, just click in the green box "Code" and select "Download ZIP". (Keep in mind that if you use this method to obtain the repository, if an update occour and you want to get it, you should download the entire reposotory again, while using the git cli, you will be able to pull the changes made only in the files updated).

You can also clono the repository using git, just type:

```
git clone https://github.com/fedemoles/ZeekLogsToCSV.git
```

## Running the script

Before running the script. You will need to change the variables "FILEPATH" and "OUTPATH". These variables indicate the location of the original logs, and the location where the new logs will be saved in csv format respectively.

Go to the directory where the script "ZeekToCSV.sh" is located and type:

```
sh ZeekToCSV.sh
```

## Examples

In the examples folder, you can find a few logs in the original Zeek format (examples/zeek) and the same logs converted to csv can be found in that folder (examples/csv).
