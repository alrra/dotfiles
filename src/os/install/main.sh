#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_info "Install applications"

"./$(get_os)/main.sh"
./node.sh
./npm_packages.sh
./vim_plugins.sh
