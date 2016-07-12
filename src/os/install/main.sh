#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n\n Install applications\n"

    "./$(get_os)/main.sh"
    ./nvm.sh
    ./npm.sh
    ./vim.sh

}

main
