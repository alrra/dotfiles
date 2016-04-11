#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NPM_PACKAGES=(
    "babel-cli"
    "jshint"
    "svgo"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `NVM_DIR` is set, and if it's not, it's because
    # `~/.bash.local` was not sourced and therefore, npm won't
    # be available (this happens when the `dotfiles` are set up
    # for the first time)

    [ -z "$NVM_DIR" ] && source "$HOME/.bash.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `npm` is installed

    if ! cmd_exists "npm"; then
        print_error "npm is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure the most recent version of `npm` is installed

    execute "npm install --global npm" "npm (update)"
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the `npm` packages

    for i in ${NPM_PACKAGES[@]}; do
        execute "npm install --global $i" "$i"
    done

}

main
