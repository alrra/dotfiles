#!/bin/bash

cd "${BASH_SOURCE%/*}" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    printf '\n' | vim +PluginInstall +qall 2> /dev/null
    #     └─ simulate the ENTER keypress for
    #        the case where there are warnings
    print_result $? "Install Vim plugins"
}

main
