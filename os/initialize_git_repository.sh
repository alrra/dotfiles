#!/bin/bash

cd "${BASH_SOURCE%/*}" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r GIT_ORIGIN="$1"

    if [ -n "$GIT_ORIGIN" ]; then
        if ! is_git_repository; then

            cd ..

            git init &> /dev/null \
                && git remote add origin "$GIT_ORIGIN" &> /dev/null
            print_result $? "Initialize the 'dotfiles' git repository"

        fi
    fi

}

main "$1"
