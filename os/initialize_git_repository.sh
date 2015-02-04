#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r GIT_ORIGIN="$1"

    if [ -n "$GIT_ORIGIN" ] && ! is_git_repository; then

        # Run the following Git commands in the root of
        # the dotfiles directory, not in the `os/` directory
        cd ..

        git init &> /dev/null \
            && git remote add origin "$GIT_ORIGIN" &> /dev/null

        print_result $? "Initialize the Git repository"

    fi

}

main "$1"
