#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -r -a NPM_PACKAGES=(
    "jshint"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `npm` is installed
    if [ $(cmd_exists "npm") -eq 1 ]; then
        print_error "npm is required, please install it!\n"
        exit
    fi

    # Make sure the most recent version of `npm` is installed
    execute "npm install --global npm" "npm (update)"

    # Install the `npm` packages
    for i in ${NPM_PACKAGES[@]}; do
        execute "npm install --global $i" "$i"
    done

}

main
