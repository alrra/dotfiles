#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_info "Install applications"

"./$(get_os)/main.sh"

print_in_green "\n  ---\n\n"
./node.sh

print_in_green "\n  ---\n\n"
./npm_packages.sh

./vim_plugins.sh
