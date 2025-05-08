# TMPFILE=.transmission_output
# transmission-remote -l | head -n -1 | tail -n +2 > $TMPFILE
#
# awk 'FNR==NR{blacklist[$1]; next} !($1 in blacklist) && $8 > 1.00 {print $1}' blacklist.txt $TMPFILE | xargs -i bash -c "transmission-remote -t {} -rad"
#
N_IDS=$(($(transmission-remote  -l | wc -l)-2))

transmission-remote -l | head -n -1 | awk 'NR > 1 {print}' | sed 's/*//' | while read line; do
    ID=$(echo $line | awk '{print $1}')
    NAME=$(transmission-remote --json -t $ID --info | jq '.arguments.torrents[0].name' | sed 's/"//g')
    IS_RATIO=$(echo $line | awk '{print ($8 > 1.00)}')
    IS_DONE_AND_EXISTS=$(cat registry.txt | awk -v id="\x27$NAME\x27" -F , 'BEGIN {done=1; exists=0} $1==id{done=$3&&done; exists=1} END {print done && exists}')

    if [[ $(($IS_DONE_AND_EXISTS + IS_RATIO)) -eq 2 ]]; then
        transmission-remote -t $ID -rad
        # sed  "/^$NAME/d" registry.txt
        # awk -F, -v name="\x27$NAME\x27" '$1!=name{print}' registry.txt > tmp
        #
        # cat tmp > registry.txt
    fi
done
