#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a PROCESSES_TO_TERMINATE=(
        'SystemUIServer'
        'cfprefsd'
    )

    ./preferences/chrome.sh
    ./preferences/chrome-canary.sh
    ./preferences/dashboard.sh
    ./preferences/dock.sh
    ./preferences/finder.sh
    ./preferences/keyboard.sh
    ./preferences/language-and-region.sh
    ./preferences/maps.sh
    ./preferences/safari.sh
    ./preferences/terminal.sh
    ./preferences/textedit.sh
    ./preferences/trackpad.sh
    ./preferences/transmission.sh
    ./preferences/ui-and-ux.sh

    for i in ${PROCESSES_TO_TERMINATE[*]}; do
        killall "$i" &> /dev/null
    done

}

main
