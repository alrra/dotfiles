#!/bin/bash

cd "$(dirname "$BASH_SOURCE")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a PROCESSES_TO_TERMINATE=(
        'SystemUIServer'
        'cfprefsd'
    )

    ./set_chrome_preferences.sh
    ./set_dashboard_preferences.sh
    ./set_dock_preferences.sh
    ./set_finder_preferences.sh
    ./set_firefox_preferences.sh
    ./set_keyboard_preferences.sh
    ./set_language_and_region_preferences.sh
    ./set_maps_preferences.sh
    ./set_safari_preferences.sh
    ./set_terminal_preferences.sh
    ./set_textedit_preferences.sh
    ./set_trackpad_preferences.sh
    ./set_transmission_preferences.sh
    ./set_ui_and_ux_preferences.sh
    ./set_xcode_preferences.sh

    for i in ${PROCESSES_TO_TERMINATE[*]}; do
        killall "$i" &> /dev/null
    done

}

main
