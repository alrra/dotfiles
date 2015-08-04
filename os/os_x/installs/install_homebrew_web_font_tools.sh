#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Webfont tools
    # https://github.com/bramstein/homebrew-webfonttools

    if cmd_exists 'brew' \
        && brew_tap 'bramstein/webfonttools'; then

        brew_install 'TTF/OTF → WOFF' 'sfnt2woff'
        brew_install 'TTF/OTF → WOFF (Zopfli)' 'sfnt2woff-zopfli'
        brew_install 'WOFF2' 'woff2'

    fi

}

main
