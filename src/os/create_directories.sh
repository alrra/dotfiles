#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

declare -a DIRECTORIES=(
    "$HOME/Downloads/torrents"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    for i in "${DIRECTORIES[@]}"; do
        mkd "$i"
    done

}

main
