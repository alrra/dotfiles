#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {

    if ! cmd_exists 'brew'; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
        print_result $? 'brew'
    fi

    if cmd_exists 'brew'; then
        execute 'brew update' 'brew (update)'
        execute 'brew upgrade --all' 'brew (upgrade)'
    fi

}

main
