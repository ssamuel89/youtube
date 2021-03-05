#!/bin/bash

if ! mkdir /tmp/ytupload.lock; then
       echo "Running"
       exit 1
fi
trap 'rm -rf /tmp/ytupload.lock' EXIT

limit=0
store="/home/scott/youtube/videos"
logfile="/tmp/ytupload.log"

echo "========== Starting Upload Script ==========" >> $logfile

echo "========== Rclone gdrive move ==========" >> $logfile
rclone move -u -vvvvv --ignore-existing --min-age 1h --bwlimit $limit --log-file $logfile $store gdrive:Backups/youtube
echo "========== Removing empty folders ==========" >> $logfile
find $store -empty -delete >> $logfile

echo "========== Script Complete ============" >> $logfile
