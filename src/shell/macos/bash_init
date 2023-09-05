#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set up Homebrew.

set_homebrew() {
    HARDWARE="$(uname -m)"
    prefix=""

    if [ "$HARDWARE" == "arm64" ]; then
        prefix="/opt/homebrew"
    elif [ "$HARDWARE" == "x86_64" ]; then
        prefix="/usr/local"
    fi

    eval "$($prefix/bin/brew shellenv)"
}

set_homebrew
unset -f set_homebrew

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure Homebrew to not auto-update before running commands
# such as: `brew install`, `brew upgrade`, and `brew tap`.
#
# https://docs.brew.sh/Manpage#environment

export HOMEBREW_NO_AUTO_UPDATE=1
