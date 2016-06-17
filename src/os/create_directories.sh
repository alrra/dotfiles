#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a DIRECTORIES=(
        "$HOME/Downloads/torrents"
    )

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Create directories"

    for i in "${DIRECTORIES[@]}"; do
        mkd "$i"
    done

}

main
