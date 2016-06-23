#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_info " App Store"

execute "defaults write com.apple.appstore ShowDebugMenu -bool true" \
    "Enable debug menu"

killall "App Store" &> /dev/null
