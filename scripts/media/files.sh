N_IDS=$(($(transmission-remote  -l | wc -l)-2))

transmission-remote -l | head -n -1 | awk 'NR > 1 {print $1}' | sed 's/*//' | while read ID; do
DATA=$(transmission-remote --json -t $ID -f | jq '.arguments.torrents[] | [.name, (.files[] | select(.name | test("[mp4|mkv]$")) | .name)] | @csv' | sed 's/["|\\]//g')
    TORRENT_NAME=$(echo $DATA | cut -d, -f1)
    TORRENT_FILES=$(echo $DATA | cut -d, -f2-)

    echo $TORRENT_FILES | tr ',' '\n' | xargs -I{} sh -c "echo '$TORRENT_NAME','{}',0"




    # transmission-remote --json -t $ID -f | jq '.arguments.torrents[] | .files[] | select(.name | test("[mp4|mkv]$")) | .name' | sed 's/"//g' | while read p; do
    #     echo $p
    #     echo $ID,$p,0 >> registry.txt
    # done
    #
done
