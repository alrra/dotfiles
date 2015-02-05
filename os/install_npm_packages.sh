#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -r -a NPM_PACKAGES=(
    "jshint"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Make sure the most recent version of `npm` is installed
    execute "npm install --global npm" "npm (update)"

    # Install the `npm` packages
    for i in ${NPM_PACKAGES[@]}; do
        execute "npm install --global $i" "$i"
    done

}

main
