#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    # execute 'defaults write NSGlobalDomain AppleLanguages -array "en"' \
    #     'Set language'

    # execute 'defaults write NSGlobalDomain AppleLocale -string "en_RO@currency=EUR"' \
    #     'Set locale'

    execute 'defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"' \
        'Set measurement units'

    # execute 'sudo systemsetup -settimezone "Europe/Bucharest"' \
    #     'Set timezone'

    execute 'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false' \
        'Disable auto-correct'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Language & Region\n\n'
    set_preferences

}

main
