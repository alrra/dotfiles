#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local HOMEBREW_PREFIX=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `brew` is installed
    if [ $(cmd_exists "brew") -eq 1 ]; then
        print_error "Brew is required, please install it!\n"
        exit 1
    fi

    # Check is `bash` is installed
    if [ $(brew list bash &> /dev/null; printf $?) -ne 0 ]; then
        print_error "Bash is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    HOMEBREW_PREFIX="$(brew --prefix)"

    # Add the path of the bash version installed through Homebrew
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if [ -z "$(cat /etc/shells | grep "$HOMEBREW_PREFIX")" ]; then
        sudo sh -c "printf \"$HOMEBREW_PREFIX/bin/bash\n\" >> /etc/shells"
        print_result $? "Add \`$HOMEBREW_PREFIX/bin/bash\` in \`/etc/shells\`"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Make OS X use the bash version installed through Homebrew
    # https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/chsh.1.html

    chsh -s "$HOMEBREW_PREFIX/bin/bash" &> /dev/null
    print_result $? "Use latest version of Bash"

}

main
