#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_chrome_canary_preferences() {

    execute 'defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false' \
        'Disable backswipe'

    execute 'defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true' \
        'Expand print dialog by default'

    execute 'defaults write com.google.Chrome.canary DisablePrintPreview -bool true' \
        'Use system-native print preview dialog'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Chrome Canary\n\n'
    set_chrome_canary_preferences

	killall 'Google Chrome Canary' &> /dev/null

}

main
