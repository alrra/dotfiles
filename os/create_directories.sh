#!/bin/bash

cd "${BASH_SOURCE%/*}" && source "utils.sh"

declare -a DIRECTORIES=(
    "$HOME/archive"
    "$HOME/Downloads/torrents"
    "$HOME/projects"
    "$HOME/server"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    for i in ${DIRECTORIES[@]}; do
        mkd "$i"
    done
}

main
