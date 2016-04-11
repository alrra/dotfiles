#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write NSGlobalDomain AppleKeyboardUIMode -int 3" \
        "Enable full keyboard access for all controls"

    execute "defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false" \
        "Disable press-and-hold in favor of key repeat"

    execute "defaults write NSGlobalDomain 'InitialKeyRepeat_Level_Saved' -int 15" \
        "Set delay until repeat"

    execute "defaults write NSGlobalDomain KeyRepeat -int 2" \
        "Set the key repeat rate to fast"

    execute "defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false" \
        "Disable smart quotes"

    execute "defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false" \
        "Disable smart dashes"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Keyboard\n\n"
    set_preferences

}

main
