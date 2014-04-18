#!/bin/bash

# Homebrew Formulae
# https://github.com/Homebrew/homebrew
declare -a HOMEBREW_FORMULAE=(
    "bash-completion"
    "git"
    "imagemagick --with-webp"
    "phinze/cask/brew-cask"
    "vim --override-system-vi"
    "zopfli"
)

# Homebrew Casks
# https://github.com/phinze/homebrew-cask
declare -a HOMEBREW_CASKS=(
    "android-file-transfer"
    "chromium"
    "dropbox"
    "flash"
    "firefox"
    "gimp-lisanet"
    "google-chrome"
    "imagealpha"
    "imageoptim"
    "licecap"
    "libreoffice"
    "macvim"
    "opera"
    "opera-next"
    "the-unarchiver"
    "transmission"
    "virtualbox"
    "vlc"
)

# Homebrew Alternate Casks
# https://github.com/caskroom/homebrew-versions
declare -a HOMEBREW_ALTERNATE_CASKS=(
    "google-chrome-canary"
    "firefox-nightly"
    "opera-developer"
    "webkit-nightly"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_applications() {

    local i="", tmp=""

    # XCode Command Line Tools
    if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
        xcode-select --install &> /dev/null

        # Wait until the XCode Command Line Tools are installed
        while [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; do
            sleep 5
        done
    fi

    print_success "XCode Command Line Tools"
    printf "\n"

    # Install Node.js (and npm)
    if [ $(cmd_exists "node") -eq 1 ]; then

        # Get the name of the `.pkg` file containing the latest Node.js version
        tmp="$(curl -sSL http://nodejs.org/dist/latest | sed -n 's/.*href="\(.*pkg\)".*/\1/p')"

        # Download `.pkg` file
        $(curl -sSL "http://nodejs.org/dist/latest/$tmp" -o /tmp/$tmp)

        if [ $? -eq 0 ]; then
            print_success "Download '$tmp'"

            # Open the `.pkg` file
            open "/tmp/$tmp"

            # Wait for Node.js to be installed
            while [ $(cmd_exists "node") -eq 1 ]; do
                sleep 5;
            done

            print_success "Node.js and npm"
        else
            print_error "Download '$tmp'"
        fi
    fi

    # Homebrew
    if [ $(cmd_exists "brew") -eq 1 ]; then
        printf '\n' | ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        #  └─ simulate ENTER keypress
        print_result $? "brew"
    fi

    if [ $(cmd_exists "brew") -eq 0 ]; then

        execute "brew update" "brew [update]"
        execute "brew upgrade" "brew [upgrade]"
        execute "brew cleanup" "brew [cleanup]"

        # Homebrew formulae
        for i in ${!HOMEBREW_FORMULAE[*]}; do
            tmp="${HOMEBREW_FORMULAE[$i]}"
            [ $(brew list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                && print_success "$tmp" \
                || execute "brew install $tmp" "$tmp"
        done

        printf "\n"

        # Homebrew casks
        if [ $(brew list brew-cask &> /dev/null; printf $?) -eq 0 ]; then

            for i in ${!HOMEBREW_CASKS[*]}; do
                tmp="${HOMEBREW_CASKS[$i]}"
                [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                    && print_success "$tmp" \
                    || execute "brew cask install $tmp" "$tmp"
            done

            printf "\n"

            # Homebrew alternate casks
            brew tap caskroom/versions &> /dev/null

            if [ $(brew tap | grep "caskroom/versions" &> /dev/null; printf $?) -eq 0 ]; then
                for i in ${!HOMEBREW_ALTERNATE_CASKS[*]}; do
                    tmp="${HOMEBREW_ALTERNATE_CASKS[$i]}"
                    [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                        && print_success "$tmp" \
                        || execute "brew cask install $tmp" "$tmp"
                done
            fi
        fi

    fi

}
