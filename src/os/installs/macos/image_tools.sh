#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Image Tools\n\n"

brew_install "ImageMagick" "imagemagick"
brew_install "ImageOptim" "imageoptim" "--cask"
brew_install "pngquant" "pngquant"
