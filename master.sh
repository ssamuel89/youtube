#!/bin/bash 

if ! mkdir /tmp/youtube.lock; then
	echo "Running"
	exit 1
fi
trap 'rm -rf /tmp/youtube.lock' EXIT

#Cleanup from last run
rm -rf /tmp/youtube

cat channels.txt | while read line || [[ -n $line ]];
do
	python3 /usr/local/bin/youtube-dl --ignore-errors --download-archive  --embed-thumbnail --merge-output-format mp4 "/home/scott/youtube/archivefiles/$line.txt" -o "/tmp/youtube/$line/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" https://www.youtube.com/c/$line/playlists --exec 'sync && bash -x /home/scott/youtube/rclone.sh' >> /tmp/downloadmv.log 2>&1
done
