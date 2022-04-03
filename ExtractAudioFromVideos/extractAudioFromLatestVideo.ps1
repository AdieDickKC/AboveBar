echo "Audio extraction script running"
Set-Location -Path "C:\Users\ABC Video Recorder\Videos"
$lastVideos = Get-ChildItem -Filter *.mp4 | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1
Foreach ($infileObject in $lastVideos) {
    $infile = $infileObject.Name
    echo "Last file $infile"
    if ($infile -eq "DoNotDelete-ProcessedToHere.mp4") {
        # in this case the last file touched was the marker and no new services have been recorded
        echo "No new files to process"
        continue
    } else {
        # touch the marker file so we don't process this again
        Remove-Item "DoNotDelete-ProcessedToHere.mp4"
        New-Item "DoNotDelete-ProcessedToHere.mp4"
        echo "Processing $infile"
    }
    $infileHash = Get-FileHash $infile
	$outfile = $infile -replace "mp4$", "mp3"
    $mkvfile = $infile -replace "mp4$", "mkv"
    echo "infile hash: $infileHash"

	echo "Processing $infile to $outfile"
	ffmpeg -i $infile -codec:a libmp3lame -q:a 3 "C:\Users\ABC Video Recorder\Dropbox\ABC Recordings\$outfile"
    if (-not(Test-Path -Path "C:\Users\ABC Video Recorder\Dropbox\ABC Recordings\$outfile" -PathType Leaf)) {
        throw "Error writing mp3 file - will not continue"
    }


    echo "Backing up to external drive F:"
    Copy-Item "$infile" "F:\ABC Service Videos Backup\"
    $backupHash = Get-FileHash "F:\ABC Service Videos Backup\$infile"
    echo "backup hash: $backupHash"

    echo "Copying to OneDrive"
    Copy-Item "C:\Users\ABC Video Recorder\Dropbox\ABC Recordings\$outfile" "C:\Users\ABC Video Recorder\Above Bar Church\Sundays - Documents\Recordings\Raw Audio\"
    # only move the file to onedrive if it's backed up to the backup drive correctly
    if ($infileHash.Hash -eq $backupHash.Hash) {
        echo "Backup verified, moving mp4 to OneDrive"
        Move-Item "$infile" "C:\Users\ABC Video Recorder\Above Bar Church\Sundays - Documents\Recordings\Raw Video\"
        echo "Deleting obsolete $mkvfile"
        Remove-Item "$mkvfile"
    } else {
            echo "Backup NOT verified"
    }
}
echo "Audio extraction script complete"
