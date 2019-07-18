#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Productivity CLI\n\n"

brew_install "Mackup" "mackup"

print_in_purple "\n   Productivity IDE\n\n"

brew_install "Alfred" "alfred" "caskroom/cask" "cask"
brew_install "Bartender" "bartender" "caskroom/cask" "cask"