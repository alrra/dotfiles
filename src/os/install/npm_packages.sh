#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_npm_package() {
    execute "npm install --silent --global $1" "${2:-$1}"
}

install_npm_packages() {

    declare -r -a NPM_PACKAGES=(
        "babel-cli"
        "jshint"
        "svgo"
    )

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${NPM_PACKAGES[@]}"; do
        install_npm_package "$i"
    done

}

update_npm() {
    install_npm_package "npm" "npm (update)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `NVM_DIR` is set, and if it's not, it's because
    # `~/.bash.local` was not sourced (this happens when the
    # `dotfiles` are set up for the first time)

    if [ -z "$NVM_DIR" ] || ! cmd_exists "npm"; then
        . "$HOME/.bash.local"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info " npm"

    update_npm

    printf "\n"
    install_npm_packages

}

main
