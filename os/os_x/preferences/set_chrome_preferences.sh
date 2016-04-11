#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false" \
        "Disable backswipe"

    execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
        "Expand print dialog by default"

    execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
        "Use system-native print preview dialog"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Chrome\n\n"
    set_preferences

    killall "Google Chrome" &> /dev/null

}

main
