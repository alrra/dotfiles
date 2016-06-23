#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_info " Dashboard"

execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
    "Disable Dashboard"

# 'killall Dashboard' doesn't actually do anything. To apply
# the changes for Dashboard, 'killall Dock' is enough as `Dock`
# is `Dashboard`'s parent process.

killall "Dock" &> /dev/null
