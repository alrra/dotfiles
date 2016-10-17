#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Language & Region\n\n"

execute "defaults write -g AppleLanguages -array 'en'" \
    "Set language"

execute "defaults write -g AppleMeasurementUnits -string 'Centimeters'" \
    "Set measurement units"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable auto-correct"
