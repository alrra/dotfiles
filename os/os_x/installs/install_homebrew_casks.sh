#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Homebrew Casks
    # https://github.com/caskroom/homebrew-cask

    if cmd_exists 'brew' \
        && brew_tap 'caskroom/cask'; then

        brew_install 'Homebrew Cask' 'caskroom/cask/brew-cask'
        printf '\n'

        brew_install 'Android File Transfer' 'android-file-transfer' 'cask'
        brew_install 'Atom' 'atom' 'cask'
        brew_install 'Chrome' 'google-chrome' 'cask'
        brew_install 'Chromium' 'chromium' 'cask'
        brew_install 'Dropbox' 'dropbox' 'cask'
        brew_install 'Firefox' 'firefox' 'cask'
        brew_install 'Flash' 'flash' 'cask'
        brew_install 'GIMP' 'lisanet-gimp' 'cask'
        brew_install 'ImageOptim' 'imageoptim' 'cask'
        brew_install 'LibreOffice' 'libreoffice' 'cask'
        brew_install 'LICEcap' 'licecap' 'cask'
        brew_install 'MacVim' 'macvim' 'cask'
        brew_install 'Opera' 'opera' 'cask'
        brew_install 'Spectacle' 'spectacle' 'cask'
        brew_install 'Transmission' 'transmission' 'cask'
        brew_install 'Unarchiver' 'the-unarchiver' 'cask'
        brew_install 'VirtualBox' 'virtualbox' 'cask'
        brew_install 'VLC' 'vlc' 'cask'

    fi

}

main
