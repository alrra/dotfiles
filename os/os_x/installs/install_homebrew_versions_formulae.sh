#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Homebrew Versions Formulae
    # https://github.com/Homebrew/homebrew-versions

    if cmd_exists 'brew' \
        && brew_tap 'homebrew/versions'; then

        brew_install 'Bash Completion 2' 'bash-completion2'

    fi

}

main
