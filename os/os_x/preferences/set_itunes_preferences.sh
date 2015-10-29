#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute 'defaults write com.apple.iTunes dontAutomaticallySyncIPods -bool true' \
        'Disable automatic device syncing'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  iTunes\n\n'
    set_preferences

    killall 'iTunes' &> /dev/null

}

main
