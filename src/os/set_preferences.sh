#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local OS=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    OS="$(get_os)" \
        || print_error "Failed to get the kernel name"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$OS" == "osx" ]; then
        ./os_x/preferences/main.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/preferences/main.sh
    fi

}

main
