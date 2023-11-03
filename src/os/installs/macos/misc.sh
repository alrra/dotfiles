#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

brew_install "Android File Transfer" "android-file-transfer" "--cask"
brew_install "Rectangle" "rectangle" "--cask"
brew_install "Unarchiver" "the-unarchiver" "--cask"
brew_install "VLC" "vlc" "--cask"
