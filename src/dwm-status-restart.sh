#!/bin/sh
log_file="$HOME/.dwm-status-restart.log"

echo "started at $(date)" >> "$log_file"
while ! amixer get Master &>/dev/null; do
    	echo "tick" >> "$log_file"
    	sleep 1
done

systemctl --user restart dwm-status.service

echo "finished at $(date)" >> "$log_file"
echo -e "\n\n\n" >> "$log_file"
