#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r OS="$(get_os)"

    if [ "$OS" == "osx" ]; then
        ./os_x/preferences/main.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/preferences/main.sh
    fi

}

main
