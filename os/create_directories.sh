#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -a DIRECTORIES=(
    "$HOME/archive"
    "$HOME/Downloads/torrents"
    "$HOME/projects"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    for i in ${DIRECTORIES[@]}; do
        mkd "$i"
    done
}

main
