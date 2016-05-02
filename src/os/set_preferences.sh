#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local OS=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    OS="$(get_os)"

    if [ "$OS" == "osx" ]; then
        ./os_x/preferences/main.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/preferences/main.sh
    fi

}

main
