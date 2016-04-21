#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.terminal FocusFollowsMouse -string true" \
        "Make the focus automatically follow the mouse"

    execute "defaults write com.apple.terminal StringEncodings -array 4" \
        "Only use UTF-8"

    execute "osascript set_custom_terminal_theme.scpt" \
        "Set custom terminal theme"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Terminal\n\n"
    set_preferences

}

main
