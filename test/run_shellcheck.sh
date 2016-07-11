#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # ' At first you're like "shellcheck is awesome" but then you're
    #   like "wtf are we still using bash" '.
    #
    #  (from: https://twitter.com/astarasikov/status/568825996532707330)

    find \
        ../test \
        ../src/os \
        ../src/shell \
        ../src/os \
        -type f \
        ! -path '../src/shell/curlrc' \
        ! -path '../src/shell/inputrc' \
        ! -path '../src/shell/screenrc' \
        ! -path '../src/shell/tmux.conf' \
        ! -path '../src/os/preferences/macos/set_terminal_theme.applescript' \
        ! -path '../src/os/preferences/macos/Solarized Dark.terminal' \
        -exec shellcheck \
                -e SC1090 \
                -e SC1091 \
                -e SC2155 \
                -e SC2164 \
        {} +

    print_result $? "Run code through ShellCheck"

}

main
