#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r CMD="$3"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"

    [ $(brew "$CMD" list "$FORMULA" &> /dev/null; printf $?) -eq 0 ] \
        && print_success "$FORMULA_READABLE_NAME" \
        || execute "brew $CMD install $FORMULA" "$FORMULA_READABLE_NAME"

}

brew_tap() {

    declare -r REPOSITORY="$1"

    brew tap "$REPOSITORY" &> /dev/null

    [ "$(brew tap | grep "$REPOSITORY" &> /dev/null; printf $?)" -eq 0 ] \
        && (print_success "brew tap ($REPOSITORY)\n"; return 0) \
        || (print_error "brew tap ($REPOSITORY)\n"; return 1)

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local i="", tmp=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # XCode Command Line Tools

    if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
        xcode-select --install &> /dev/null

        # Wait until the XCode Command Line Tools are installed
        while [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; do
            sleep 5
        done
    fi

    print_success "XCode Command Line Tools\n"


    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Homebrew
    if [ $(cmd_exists "brew") -eq 1 ]; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
        print_result $? "brew"
    fi

    if [ $(cmd_exists "brew") -eq 0 ]; then

        execute "brew update" "brew (update)"
        execute "brew upgrade --all" "brew (upgrade)"

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Homebrew Formulae
        # https://github.com/Homebrew/homebrew

        brew_install "Bash 4" "bash"
        brew_install "Cask" "caskroom/cask/brew-cask"
        brew_install "FFmpeg" "ffmpeg"
        brew_install "Git" "git"
        brew_install "ImageMagick" "imagemagick --with-webp"
        brew_install "tmux" "tmux"
        brew_install "vim" "vim --override-system-vi"
        brew_install "Zopfli" "zopfli"

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Homebrew Versions Formulae
        # https://github.com/Homebrew/homebrew-versions

        brew_tap "homebrew/versions" \
            && (
                brew_install "Bash Completion 2" "bash-completion2"
            )

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Homebrew Casks
        # https://github.com/caskroom/homebrew-cask

        brew_tap "caskroom/cask" \
            && (
                brew_install "Android File Transfer" "android-file-transfer"  "cask"
                brew_install "Atom" "atom" "cask"
                brew_install "Chrome" "google-chrome" "cask"
                brew_install "Chromium" "chromium" "cask"
                brew_install "Dropbox" "dropbox" "cask"
                brew_install "Firefox" "firefox" "cask"
                brew_install "Flash" "flash" "cask"
                brew_install "GIMP" "lisanet-gimp" "cask"
                brew_install "ImageOptim" "imageoptim" "cask"
                brew_install "LibreOffice" "libreoffice" "cask"
                brew_install "LICEcap" "licecap" "cask"
                brew_install "MacVim" "macvim" "cask"
                brew_install "Opera" "opera" "cask"
                brew_install "Spectacle" "spectacle" "cask"
                brew_install "Transmission" "transmission" "cask"
                brew_install "Unarchiver" "the-unarchiver" "cask"
                brew_install "VirtualBox" "virtualbox" "cask"
                brew_install "VLC" "vlc" "cask"
            )

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Homebrew Alternate Casks
        # https://github.com/caskroom/homebrew-versions

        brew_tap "caskroom/versions" \
            && (
                brew_install "Chrome Canary" "google-chrome-canary" "cask"
                brew_install "Firefox Developer Edition" "firefoxdeveloperedition" "cask"
                brew_install "Firefox Nightly" "firefox-nightly" "cask"
                brew_install "Opera Beta" "opera-beta" "cask"
                brew_install "Opera Developer" "opera-developer" "cask"
                brew_install "WebKit" "webkit-nightly" "cask"
            )

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Webfont tools
        # https://github.com/bramstein/homebrew-webfonttools

        brew_tap "bramstein/webfonttools" \
            && (
                brew_install "TTF/OTF → WOFF (Zopfli)" "sfnt2woff-zopfli"
                brew_install "TTF/OTF → WOFF" "sfnt2woff"
                brew_install "WOFF2" "woff2"
            )

        print_in_green "\n  ---\n\n"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        execute "brew cleanup" "brew (cleanup)"

    fi

}

main
