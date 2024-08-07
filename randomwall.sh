#!/bin/bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script is in bash (not posix shell), because the RANDOM variable
# we use is not defined in posix

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=4

# This controls (in seconds) when to switch to the next image
INTERVAL=300
meaw=True
while meaw=True; do
	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img"
      wal -i "$img"
      cp ~/.cache/wal/colors-waybar.css ~/
      cp ~/.cache/wal/colors-waybar.css ~/.config/waybar
      cp -r ~/.cache/wal/colors-starship.toml ~/.config/starship.toml
      wpg -a $selected_wallpaper_path
      wpg -s $selected_wallpaper_path 
      pkill waybar
      waybar &
      kitty &
      cp ~/.cache/wal/color.ini ~/.config/spicetify/Themes/sleek
      spicetify update
      killall randomwall.sh
		done
done
