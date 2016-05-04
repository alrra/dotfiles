#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Install "ShellCheck" if needed

    if ! cmd_exists "shellcheck"; then
        brew install shellcheck &> /dev/null
        print_result $? "Install ShellCheck"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # ' At first you're like "shellcheck is awesome" but then you're
    #   like "wtf are we still using bash" '
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
        ! -path '../src/os/os_x/preferences/set_custom_terminal_theme.scpt' \
        ! -path '../src/os/os_x/preferences/solarized_dark.terminal' \
        -exec shellcheck \
                -x \
                -e SC1090 \
                -e SC1091 \
                -e SC2155 \
        {} +

    print_result $? "Run code through ShellCheck"

}

main
