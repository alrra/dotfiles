#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true" \
        "Prevent Photos from opening automatically when devices are plugged in"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Photos\n\n"
    set_preferences

    killall "Photos" &> /dev/null

}

main
