#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {

    # Homebrew Formulae
    # https://github.com/Homebrew/homebrew

    if cmd_exists 'brew'; then

        brew_install 'Bash 4' 'bash'
        brew_install 'FFmpeg' 'ffmpeg'
        brew_install 'Git' 'git'
        brew_install 'Homebrew-Cask' 'caskroom/cask/brew-cask'
        brew_install 'ImageMagick' 'imagemagick --with-webp'
        brew_install 'Zopfli' 'zopfli'
        brew_install 'tmux' 'tmux'
        brew_install 'vim' 'vim --override-system-vi'

    fi

}

main
