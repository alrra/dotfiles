#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.sh" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./install_xcode.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_green "\n  ---\n\n"
./install_homebrew.sh
brew_update
brew_upgrade

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_green "\n  ---\n\n"
./install_bash.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_green "\n  ---\n\n"
./install_apps.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_green "\n  ---\n\n"
brew_cleanup
