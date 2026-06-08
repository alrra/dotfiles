#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Chromium\n\n"

execute "defaults write org.chromium.Chromium AppleEnableSwipeNavigateWithScrolls -bool false" \
    "Disable backswipe"

execute "defaults write org.chromium.Chromium PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print dialog by default"

execute "defaults write org.chromium.Chromium DisablePrintPreview -bool true" \
    "Use system-native print preview dialog"

killall "Chromium" &> /dev/null
