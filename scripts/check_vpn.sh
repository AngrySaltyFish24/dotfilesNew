if [[ `nmcli connection | grep vpn | awk '{print $4}'` == 'wlp9s0' ]]; then echo 'true'; else echo 'false'; fi
