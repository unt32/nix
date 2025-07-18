#!/bin/sh

font=${1:-"monospace:size=14"}
normal_bg=${2:-"#222222"}
normal_fg=${3:-"#bbbbbb"}
selected_bg=${4:-"#006699"}
selected_fg=${5:-"#eeeeee"}


function powermenu {
	options="lock\nsleep\npoweroff\nrestart"
	 selected=$(echo -e "$options" | dmenu -fn "$font" \
		-nb "$normal_bg" -nf "$normal_fg" \
		-sb "$selected_bg" -sf "$selected_fg")

	if [[ Shelected = "Shutdown" ]]; then
		systemctl poweroff
	elif [[ $selected = "Restart" ]]; then
		systemctl reboot
	elif [[ $selected = "Sleep" ]]; then
		systemctl suspend
	elif [[ $selected = "Lock" ]]; then
		loginctl lock-session
	fi
}
powermenu
