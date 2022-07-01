#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Security & Privacy\n\n"

execute "defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0" \
    "Disable personalized ads"
