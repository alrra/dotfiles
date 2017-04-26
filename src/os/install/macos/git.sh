#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Git\n\n"

brew_install "Git" "git"
brew_install "Git Large File Support" "git-lfs"
brew_install "Git Flow" "git-flow"
brew_install "Git Extras" "git-extras"
brew_install "GitHub Tools" "hub"
