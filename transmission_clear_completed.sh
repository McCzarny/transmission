#!/bin/bash
# the folder to move completed downloads to

# port, username, password

# use transmission-remote to get torrent list from transmission-remote list
# use sed to delete first / last line of output, and remove leading spaces
# use cut to get first field from each line
TORRENTLIST=`transmission-remote --list | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" "  --fields=1`

SOURCEDIR='/incomplete'
MOVEDIR='/downloads'
DISTOWNER='root:root'

# for each torrent in the list
for TORRENTID in $TORRENTLIST
do
    # check torrents current state is
    STATE_STOPPED=`transmission-remote $SERVER --torrent $TORRENTID --info | grep "State: Finished"`
    FROM_DOWNLOADING=`transmission-remote $SERVER --torrent $TORRENTID --info | grep "$SOURCEDIR"`

    if [ "$STATE_STOPPED" ]; then
        # move the files and remove the torrent from Transmission
      NAME=`transmission-remote --torrent $TORRENTID --info | grep "Name:"`
      /storage/scripts/push.sh "Download finished" "$NAME"  
      if [ "$FROM_DOWNLOADING" ]; then
        transmission-remote --torrent $TORRENTID --move $MOVEDIR
        chown -R $DISTOWNER $MOVEDIR
      fi
      
      transmission-remote --torrent $TORRENTID --remove
    fi
done
