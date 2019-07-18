#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development CLI\n\n"

brew_install "ShellCheck" "shellcheck"
brew_install "Watchman" "watchman"

print_in_purple "\n   Development IDE\n\n"

brew_install "Dash" "dash" "caskroom/cask" "cask"
brew_install "iTerm 2" "iterm2" "caskroom/cask" "cask"
brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"


