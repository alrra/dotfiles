#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true &&
             defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 &&
             defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1" \
        "Enable 'Tap to click'"

    execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true &&
             defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true &&
             defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 &&
             defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0" \
        "Map 'click or tap with two fingers' to the secondary click"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Trackpad\n\n"
    set_preferences

}

main
