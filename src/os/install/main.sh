#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n\n Installs\n\n"

"./$(get_os)/main.sh"
./nvm.sh
./npm.sh
./vim.sh
