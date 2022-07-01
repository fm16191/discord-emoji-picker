#!/usr/bin/env bash

# SCRIPT VARIABLES
full_path=$(echo "${BASH_SOURCE:-$0}" | xargs realpath)
script_name=$(basename "$0")
path="${full_path%"/$script_name"}"

emojis_path="$path/emojis"
[ -d "$emojis_path" ] || mkdir "$emojis_path"

# emotify_path="$path/emotify.sh"
icon_path="/usr/share/icons/iconify"

create="Create new emoji"
create_icon="\0icon\x1fadd"
create_bg_remove="Create emoji and remove its bg"
delete_emoji="Delete emoji"

# SCRIPT FUNCTIONS
get_emoji(){
    if [ -f ~/emojis/"$1".png ];
    then
        # If emoji already exists
        xclip -selection clipboard -t image/png -i "$emojis_path/$1".png
    fi
}

delete_emoji(){
    rm -f "$emojis_path/$1.png"
    rm -f "$icon_path/$1.png"
}

create_emoji(){
    # Create new emoji
    # if not from filename : dl from url

    # If no emoji name
    if [ "$2" == "" ];
    then 
        exit
    fi

    from="/tmp/emotify"
    to="$emojis_path/$2.png"
    if [ ! -f "$1" ];
    then
        wget "$1" -O "$from"
    else
        from="$1"
    fi

    # Create new emoji & remove background
    if [ -n "$3" ];
    then
        echo "Removing background : $3"
        convert "$from" -define format:png -fuzz 20%% -transparent "$3" -resize 60x60 "$to"
    else
        convert "$from" -resize 60x60 -define format:png "$to"
    fi
    cp "$to" "$icon_path/"
    xclip -selection clipboard -t image/png -i "$to"

    # convert u3.png -resize 100x100 u.png
}


# SCRIPT START
icons_emojis=""
# find . -printf "%T@ %f\n" | sort -nr | cut  -d " " -f 2-
# for e in $(find ~/emojis -type f -name "*.png" -printf '%f\n' | sed "s/\.png//g"); do
for e in $(find "$emojis_path" -type f -name "*.png" -printf '%T@ %f\n' | sort -nr | cut -d " " -f 2- | sed "s/\.png//g"); do
    icons_emojis="$icons_emojis$e\0icon\x1f$e\n"
done

chosen="$(echo -e "$create$create_icon\n$create_bg_remove\n$delete_emoji$create_icon\n$icons_emojis" | rofi -p -dmenu -show-icons -icon-theme "iconify")"
# -selected-row 2

# Escaped
if [ "$chosen" = "" ];
then
    exit
fi

case "$chosen" in
    "")
        exit
    ;;
    "$create")
        emoji_name=$(rofi -dmenu -i -no-fixed-num-lines -p "Emoji name ?" \
        -theme "$path/confirm.rasi")

        create_emoji "$(xclip -selection clipboard -o -r)" "$emoji_name"
        # $emotify_path "$(xclip -selection clipboard -o -r)" "$emoji_name"
    ;;
    "$create_bg_remove")
        emoji_name=$(rofi -dmenu -i -no-fixed-num-lines -p "Emoji name ?" \
        -theme "$path/confirm.rasi")
        bg_color=$(rofi -dmenu -i -no-fixed-num-lines -p "Background color ?" \
        -theme "$path/confirm.rasi")

        create_emoji "$(xclip -selection clipboard -o -r)" "$emoji_name" "$bg_color"
        # $emotify_path "$(xclip -selection clipboard -o -r)" "$emoji_name" "$bg_color"
    ;;
    "$delete_emoji")
        emoji_name=$(rofi -dmenu -i -no-fixed-num-lines -p "Emoji name ?" \
            -theme "$path/confirm.rasi")

        delete_emoji "$emoji_name"
        # $emotify_path "delete" "$emoji_name"
    ;;
    *)
        get_emoji "$chosen"
        # $emotify_path "$chosen";
esac
