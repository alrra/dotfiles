#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development Tools\n\n"

brew_install "yarn" "yarn"
brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"
brew_install "Kaleidoscope" "kaleidoscope" "caskroom/cask" "cask"
brew_install "Docker" "docker" "caskroom/cask" "cask"
brew_install "Kitematic" "kitematic" "caskroom/cask" "cask"
brew_install "Smart Git" "smartgit" "caskroom/cask" "cask"