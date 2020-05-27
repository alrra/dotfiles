#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"

install_packabe "GNOME tweaks" "gnome-tweaks"

execute "gsettings set org.gnome.desktop.background picture-options 'stretched'" \
    "Set desktop background image options"

execute "gsettings set org.gnome.libgnomekbd.keyboard layouts \"[ 'us', 'si' ]\"" \
    "Set keyboard languages"

execute "gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'"