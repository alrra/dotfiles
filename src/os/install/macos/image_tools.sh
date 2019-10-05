#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Image Tools\n\n"

brew_install "GIMP" "lisanet-gimp" "homebrew/cask" "cask"
brew_install "ImageAlpha" "imagealpha" "homebrew/cask" "cask"
brew_install "ImageMagick" "imagemagick"
brew_install "ImageOptim" "imageoptim" "homebrew/cask" "cask"
brew_install "LICEcap" "licecap" "homebrew/cask" "cask"
