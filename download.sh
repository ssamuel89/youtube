#!/bin/bash 

if ! mkdir /tmp/$1.lock; then
	echo "Running"
	exit 1
fi
trap 'rm -rf /tmp/$1.lock' EXIT

python3 /usr/local/bin/youtube-dl --ignore-errors --cookies "/home/scott/youtube/cookies.txt" --download-archive "/home/scott/youtube/archivefiles/$1.txt" -o "/home/scott/youtube/videos/%(uploader)s/%(playlist_title)s/%(upload_date)s - %(title)s.%(ext)s" $1 >> /tmp/youtube.log 2>&1
