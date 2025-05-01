
if [[ `nmcli connection show --active | awk 'BEGIN {x=0} $3=="vpn"{x=1} END{print x}'` -eq 1 ]]; then echo 'true'; else echo 'false'; fi
