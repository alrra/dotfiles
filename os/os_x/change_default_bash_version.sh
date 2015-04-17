#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local HOMEBREW_PREFIX=""

    # Check if `brew` is installed
    if [ $(cmd_exists "brew") -eq 1 ]; then
        print_error "Brew is required, please install it!\n"
        exit
    fi

    # Check is `bash` is installed
    if [ $(brew list bash &> /dev/null; printf $?) -ne 0 ]; then
        print_error "Bash is required, please install it!\n"
        exit
    fi

    HOMEBREW_PREFIX="$(brew --prefix)"

    # Make OS X use the bash version installed through homebrew
    [ -z "$(cat /etc/shells | grep "$HOMEBREW_PREFIX")" ] \
        && sudo sh -c 'printf "$HOMEBREW_PREFIX/bin/bash" >> /etc/shells'

    chsh -s "$HOMEBREW_PREFIX/bin/bash" &> /dev/null
    print_result $? "Use latest version of Bash"

}

main
