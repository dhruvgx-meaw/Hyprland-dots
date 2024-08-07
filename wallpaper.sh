#!/bin/bash
CACHE_DIR=$HOME/.cache/rofi_wallpaper_picker
WALLPAPERS_DIR=$HOME/wallpapers

rofi_cmd() {
	rofi -dmenu \
		-i \
		-p "" \
		-theme $HOME/.config/rofi/wallpaper/style
}

if [ ! -d "${CACHE_DIR}" ] ; then
    mkdir -p "${CACHE_DIR}"
fi

for wallpaper in "$WALLPAPERS_DIR"/*.{jpg,jpeg,png}; do
    if [ -f "$wallpaper" ]; then
        wallpaper_name=$(basename "$wallpaper")
        if [ ! -f "${CACHE_DIR}/${wallpaper_name}" ] ; then
            magick "$wallpaper" -thumbnail '320x180>' "${CACHE_DIR}/${wallpaper_name}"
        fi
    fi
done

selected_wallpaper=$(find "${WALLPAPERS_DIR}" -type f -printf "%P\n" | sort | while read -r A ; do echo -en "$A\x00icon\x1f""${CACHE_DIR}"/"$A\n" ; done | rofi_cmd)

if [[ $selected_wallpaper == "" ]]; then
    exit 1
fi

selected_wallpaper_path=$WALLPAPERS_DIR/$selected_wallpaper

swww img $selected_wallpaper_path
wal -i $selected_wallpaper_path
cp ~/.cache/wal/colors-waybar.css ~/
cp ~/.cache/wal/colors-waybar.css ~/.config/waybar
cp -r ~/.cache/wal/colors-starship.toml ~/.config/starship.toml
wpg -a $selected_wallpaper_path
wpg -s $selected_wallpaper_path
cp ~/.cache/wal/color.ini ~/.config/spicetify/Themes/sleek
spicetify apply
reload_gtk_theme
pywalfox update 
pkill waybar
waybar &
kitty &


