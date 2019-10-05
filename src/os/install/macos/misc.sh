#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

brew_install "Android File Transfer" "android-file-transfer" "homebrew/cask" "cask"
brew_install "eyeD3" "eye-d3"
brew_install "Spectacle" "spectacle" "homebrew/cask" "cask"
brew_install "Transmission" "transmission" "homebrew/cask" "cask"
brew_install "Unarchiver" "the-unarchiver" "homebrew/cask" "cask"
brew_install "VLC" "vlc" "homebrew/cask" "cask"
