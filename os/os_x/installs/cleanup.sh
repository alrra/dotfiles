#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {

    # By default, Homebrew does not uninstall older versions
    # of formulas, so, in order to remove them, `brew cleanup`
    # needs to be used
    #
    # https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/FAQ.md#how-do-i-uninstall-old-versions-of-a-formula

    if cmd_exists 'brew'; then
        execute 'brew cleanup' 'brew (cleanup)'
    fi

}

main
