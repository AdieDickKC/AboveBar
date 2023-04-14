#!/bin/bash

VIDEO_LOCATION=/Users/niced/tmp/videofolder
MARKER_FILE=DoNotDelete-ProcessedToHere.mp4

if [ ! -e $VIDEO_LOCATION/$MARKER_FILE ]
then
echo	touch $VIDEO_LOCATION/$MARKER_FILE
fi

cd $VIDEO_LOCATION
for INFILEMP4 in `find . -newer $MARKER_FILE -name "*.mp4"`
do
	HASH=`md5sum $INFILEMP4`
	echo $HASH
# outfile mp3
# check for mp3

# back up to external drive, check hash
# move to onedrive

done

echo	touch $VIDEO_LOCATION/$MARKER_FILE
