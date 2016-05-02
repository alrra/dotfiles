#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./set_privacy_preferences.sh
    ./set_terminal_preferences.sh
    ./set_ui_and_ux_preferences.sh

}

main
