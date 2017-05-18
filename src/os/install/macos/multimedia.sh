#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Multimedia\n\n"

brew_install "Hermes" "hermes" "caskroom/cask" "cask"
brew_install "Spotify" "spotify" "caskroom/cask" "cask"
brew_install "VLC" "vlc" "caskroom/cask" "cask"
