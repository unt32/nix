#!/bin/sh

echo "started at $(date)"
while ! amixer get Master &>>/dev/null; do
    	echo "tick"
    	sleep 1
done

systemctl --user restart dwm-status.service

echo "finished at $(date)"
