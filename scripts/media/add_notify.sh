#!/bin/bash

PERCENT=10
while true; do
    PERCENT=$(transmission-remote -l | awk -v id=$TR_TORRENT_ID '$1==id{print $2}' | sed 's/.$//')
    if [ $PERCENT -eq 100 ]; then
        break
    fi
    dunstify -h int:value:$PERCENT -h string:x-canonical-private-synchronous:$TR_TORRENT_ID   "Downloading Torrent" "$TR_TORRENT_NAME" -u low
    echo $?
    sleep 1
done


