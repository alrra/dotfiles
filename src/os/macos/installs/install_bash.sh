#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_bash_version() {

    local pathNewShell=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Bash` version installed through
    # `Homebrew`, and if something fails, don't continue any further

    pathNewShell="$(brew --prefix 2> /dev/null)/bin/bash"

    if [ $? -ne 0 ]; then
        print_error "Bash (get shell path)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the `Bash` version installed through `Homebrew`
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep "$pathNewShell" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$pathNewShell' | sudo tee -a /etc/shells" \
            "Bash (add '$pathNewShell' in '/etc/shells')"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Make macOS use the `Bash` version installed through `Homebrew`
    # https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/chsh.1.html

    execute \
        "sudo chsh -s '$pathNewShell'" \
        "Bash (use latest version)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Install the latest version of `Bash` and set it as the default
    # (macOS uses by default an older version of `Bash`)

    brew_install "Bash" "bash" \
        && change_default_bash_version

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Bash Completion 2" "bash-completion2" "homebrew/versions"

}

main
