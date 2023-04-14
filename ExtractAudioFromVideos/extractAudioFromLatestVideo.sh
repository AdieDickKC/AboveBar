#!/bin/bash

VIDEO_LOCATION=/Users/niced/tmp/videofolder
BACKUP_LOCATION=/Users/niced/tmp/backupfolder
ONEDRIVE_VIDEO_LOCATION=/Users/niced/tmp/onedrivefolder
ONEDRIVE_AUDIO_LOCATION=/Users/niced/tmp/onedrivefolder

MARKER_FILE=DoNotDelete-ProcessedToHere.mp4

if [ ! -e $VIDEO_LOCATION/$MARKER_FILE ]
then
	# todo - remove echo
	echo	touch $VIDEO_LOCATION/$MARKER_FILE
fi

cd $VIDEO_LOCATION
for INFILEMP4 in `find . -newer $MARKER_FILE -name "*.mp4"`
do
	HASH=`md5sum $INFILEMP4`
	echo $HASH
# outfile mp3
	OUTFILEMP3=`echo $INFILEMP4 | sed 's/mp4/mp3/'`
	echo $OUTFILEMP3
# todo - remove echo
echo ffmpeg -i $INFILEMP4 -codec:a libmp3lame -q:a 3 $OUTFILEMP3
# check for mp3

# back up to external drive, check hash
echo cp $INFILEMP4 $BACKUP_LOCATION

# move to onedrive
echo mv $INFILEMP4 $ONEDRIVE_VIDEO_LOCATION
echo mv $INFILEMP3 $ONEDRIVE_AUDIO_LOCATION

#check hash

done

# todo - remove echo
echo	touch $VIDEO_LOCATION/$MARKER_FILE
