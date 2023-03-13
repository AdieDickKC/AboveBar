FFMPEG is used to extract audio - installed to
  C:\Users\ABC Video Recorder\tools\ffmpeg-4.4-essentials_build
and then added to the system path

It's triggered:
 - AUTOMATICALLY using windows scheduled tasks about an hour after the end of each service (AM 12:30 and PM 20:00)
 - Manually, by using the "Process Recording" button on the 6-button StreamDeck - please ensure service recording has been stopped and OBS is no longer processing.
 - Manually by running "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File "C:\Users\ABC Video Recorder\Documents\mp3_extract\Extract audio from latest video"


 !!! WARNING !!!
This tool will only process a single source videom and will not process any videos older than when it was last run.
To update the timestamp on a video file to be more recent, within a command prompt issue the following command:
  copy /b <filename>+,,
