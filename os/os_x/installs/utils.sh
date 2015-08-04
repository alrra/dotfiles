#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r CMD="$3"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"

    if brew "$CMD" list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute "brew $CMD install $FORMULA" "$FORMULA_READABLE_NAME"
    fi

}

brew_tap() {

    declare -r REPOSITORY="$1"

    brew tap "$REPOSITORY" &> /dev/null
    print_result $? "brew tap $REPOSITORY\n"

    return $?

}
