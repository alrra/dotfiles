#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_firefox_preferences() {

    execute 'defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool false' \
        'Disable backswipe'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '  Firefox\n\n'
    set_firefox_preferences

    killall 'firefox' &> /dev/null

}

main
