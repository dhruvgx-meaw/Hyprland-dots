wallpaper=$(ls $HOME/wallpapers/ | grep -Ei ".png|.jpg"  | wofi -allow-images -dmenu)
path="$HOME/wallpapers"
img="${path}/${wallpaper}"
magick "$wallpaper" -thumbnail '320x180>' "$img"
swww img "$img"
wal -i "$img"
cp ~/.cache/wal/colors-waybar.css ~/
cp ~/.cache/wal/colors-waybar.css ~/.config/waybar
cp -r ~/.cache/wal/colors-starship.toml ~/.config/starship.toml
pywalfox update
pkill waybar
waybar &
