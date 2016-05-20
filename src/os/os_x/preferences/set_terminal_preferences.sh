#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n  Terminal\n\n"

execute "defaults write com.apple.terminal FocusFollowsMouse -string true" \
    "Make the focus automatically follow the mouse"

execute "defaults write com.apple.terminal StringEncodings -array 4" \
    "Only use UTF-8"

execute "./set_custom_terminal_theme.applescript" \
    "Set custom terminal theme"
