#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.Maps LastClosedWindowViewOptions '{
                localizeLabels = 1;   // show labels in English
                mapType = 11;         // show hybrid map
                trafficEnabled = 0;   // do not show traffic
             }'" \
        "Set view options"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Maps\n\n"
    set_preferences

    killall "Maps" &> /dev/null

}

main
