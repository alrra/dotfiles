#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
brew_install "VLC" "vlc" "caskroom/cask" "cask"
