#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {
    local -r ARGUMENTS="$3"
    local -r FORMULA="$2"
    local -r FORMULA_READABLE_NAME="$1"
    local -r TAP_VALUE="$4"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed.

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed,
    # check if it executed correctly.

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the specified formula/cask comes from a non-official tap,
    # trust it by default so `Homebrew` may load it.

    if [ -n "$TAP_VALUE" ] || [[ "$FORMULA" == */* ]]; then
        local -r trustTarget="${TAP_VALUE:+$TAP_VALUE/}$FORMULA"
        local -r trustType="$( [[ "$ARGUMENTS" == *--cask* ]] && printf "cask" || printf "formula" )"

        if ! brew trust "--$trustType" "$trustTarget" &> /dev/null; then
            print_error "$FORMULA_READABLE_NAME ('brew trust --$trustType $trustTarget' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula.

    # shellcheck disable=SC2086
    if brew list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute \
            "brew install --yes $FORMULA $ARGUMENTS" \
            "$FORMULA_READABLE_NAME"
    fi
}

brew_prefix() {
    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --prefix 2> /dev/null)"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get prefix)"
        return 1
    fi
}

brew_tap() {
    brew tap "$1" &> /dev/null \
        && brew trust "$1" &> /dev/null
}

brew_update() {
    execute \
        "brew update" \
        "Homebrew (update)"
}

brew_upgrade() {
    execute \
        "brew upgrade --yes" \
        "Homebrew (upgrade)"
}

remove_quarantine_attribute() {
    declare -r APP_PATH="$1"
    declare -r APP_READABLE_NAME="$2"

    # Remove the quarantine attribute set by macOS on downloaded
    # apps to avoid the "is damaged and can't be opened" or
    # gatekeeper warnings on first launch.

    execute \
        "sudo xattr -rd com.apple.quarantine '$APP_PATH'" \
        "$APP_READABLE_NAME (remove quarantine attribute)"
}
