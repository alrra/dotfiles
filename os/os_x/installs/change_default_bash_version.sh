#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local HOMEBREW_PREFIX=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed

    if ! cmd_exists "brew"; then
        print_error "Homebrew is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if latest version of `Bash` is installed

    if ! brew list bash &> /dev/null; then
        print_error "Bash 4.x is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the Bash version installed through Homebrew
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    HOMEBREW_PREFIX="$(brew --prefix)"

    if [ -z "$(cat /etc/shells | grep "$HOMEBREW_PREFIX")" ]; then
        sudo sh -c "printf \"$HOMEBREW_PREFIX/bin/bash\n\" >> /etc/shells"
        print_result $? "Bash (add \`$HOMEBREW_PREFIX/bin/bash\` in \`/etc/shells\`)"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Make OS X use the Bash version installed through Homebrew
    # https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/chsh.1.html

    chsh -s "$HOMEBREW_PREFIX/bin/bash" &> /dev/null
    print_result $? "Bash (use latest version)"

}

main
