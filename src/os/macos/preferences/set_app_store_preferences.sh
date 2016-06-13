#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "  App Store\n\n"

execute "defaults write com.apple.appstore ShowDebugMenu -bool true" \
    "Enable debug menu"

killall "App Store" &> /dev/null
