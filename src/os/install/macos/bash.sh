#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_path_to_login_shells_list() {

    declare -r NEW_SHELL_PATH="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! grep "$NEW_SHELL_PATH" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$NEW_SHELL_PATH' | sudo tee -a /etc/shells" \
            "Bash (add '$NEW_SHELL_PATH' in '/etc/shells')"
    fi

}

change_default_bash() {

    local newShellPath=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Bash`
    # version installed through `Homebrew`

    newShellPath="$(get_homebrew_bash_path)" \
        || return 1

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

    add_path_to_login_shells_list "$newShellPath"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set latest version of `Bash` as the default
    # (macOS uses by default an older version of `Bash`)

    change_login_shell "$newShellPath"

}

change_login_shell() {

    execute \
        "sudo chsh -s '$1'" \
        "Bash (use latest version)"

}

get_homebrew_bash_path() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    path="$(brew --prefix 2> /dev/null)/bin/bash"

    if [ $? -eq 0 ]; then
        printf "%s" "$path"
        return 0
    else
        print_error "Bash (get shell path)"
        return 1
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_info " Bash"

    brew_install "Bash" "bash" \
        && change_default_bash

    brew_install "Bash Completion 2" "bash-completion2" "homebrew/versions"

}

main
