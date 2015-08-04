#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Homebrew Alternate Casks
    # https://github.com/caskroom/homebrew-versions

    if cmd_exists 'brew' \
        && brew_tap 'caskroom/versions'; then

        brew_install 'Chrome Canary' 'google-chrome-canary' 'cask'
        brew_install 'Firefox Developer Edition' 'firefoxdeveloperedition' 'cask'
        brew_install 'Firefox Nightly' 'firefox-nightly' 'cask'
        brew_install 'Opera Beta' 'opera-beta' 'cask'
        brew_install 'Opera Developer' 'opera-developer' 'cask'
        brew_install 'WebKit' 'webkit-nightly' 'cask'

    fi

}

main
