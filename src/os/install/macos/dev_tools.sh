#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development Tools\n\n"

brew_install "yarn" "yarn"
brew_install "bower" "bower"

brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"
brew_install "Kaleidoscope" "kaleidoscope" "caskroom/cask" "cask"
brew_install "Docker" "docker" "caskroom/cask" "cask"
brew_install "Kitematic" "kitematic" "caskroom/cask" "cask"
brew_install "Postman" "postman" "caskroom/cask" "cask"
brew_install "SmartGit" "smartgit" "caskroom/cask" "cask"