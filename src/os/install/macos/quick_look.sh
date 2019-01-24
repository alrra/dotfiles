#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Quick Look\n\n"

brew_install "JSON" "quicklook-json" "caskroom/cask" "cask"
brew_install "Markdown" "qlmarkdown" "caskroom/cask" "cask"
