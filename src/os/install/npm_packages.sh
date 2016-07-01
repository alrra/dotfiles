#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_npm_package() {

    execute \
        ". $HOME/.bash.local \
            && npm install --silent --global $1" \
        "${2:-$1}"

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

    print_info " npm"

    update_npm
    printf "\n"
    install_npm_packages

}

main
