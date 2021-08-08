FFMPEG is used to extract audio - installed to
  C:\Users\ABC Video Recorder\tools\ffmpeg-4.4-essentials_build
and then added to the system path

It's triggered using windows scheduled tasks.

It always processes the last mp4 file created in the directory, and keeps track using a marker file.

It backs up the video file, extracts the audio to dropbox, copies to onedrive, and finally moves the video file to onedrive if the backup succeeded.
