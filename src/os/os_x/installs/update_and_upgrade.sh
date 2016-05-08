#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.sh" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if cmd_exists "brew"; then
        execute "brew update" "brew (update)"
        execute "brew upgrade --all" "brew (upgrade)"
    fi

}

main
