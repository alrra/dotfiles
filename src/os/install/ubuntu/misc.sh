#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

install_package "VLC" "vlc"
install_package "Autojump" "autojump"
install_package "Mediainfo" "mediainfo-gui"
install_package "Handbrake" "handbrake"
install_package "FFmpeg" "ffmpeg"
install_package "Tilix" "tilix"
install_package "Kylin Video" "kylin-video"
