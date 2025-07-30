#!/bin/sh

font=${1:-"monospace:size=14"}
normal_bg=${2:-"#222222"}
normal_fg=${3:-"#bbbbbb"}
selected_bg=${4:-"#006699"}
selected_fg=${5:-"#eeeeee"}


function powermenu {
	options="lock\nsleep\npoweroff\nreboot"
	 selected=$(echo -e "$options" | dmenu -fn "$font" \
		-nb "$normal_bg" -nf "$normal_fg" \
		-sb "$selected_bg" -sf "$selected_fg")

	if [[ $selected = "poweroff" ]]; then
		systemctl poweroff
	elif [[ $selected = "reboot" ]]; then
		systemctl reboot
	elif [[ $selected = "sleep" ]]; then
		systemctl suspend
	elif [[ $selected = "lock" ]]; then
		xset dpms force off
	fi
}
powermenu
