#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a DIRECTORIES=(
        "$HOME/Downloads/torrents"
    )

    for i in "${DIRECTORIES[@]}"; do
        mkd "$i"
    done

}

main
