#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous Tools\n\n"

brew_install "ShellCheck" "shellcheck"
brew_install "Visual Studio Code" "visual-studio-code" "homebrew/cask" "cask"

if [ -d "$HOME/.nvm" ]; then
    brew_install "Yarn" "yarn"
fi
