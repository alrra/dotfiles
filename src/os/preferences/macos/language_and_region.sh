#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_info " Language & Region"

execute "defaults write NSGlobalDomain AppleLanguages -array 'en'" \
    "Set language"

execute "defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters'" \
    "Set measurement units"

execute "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable auto-correct"
