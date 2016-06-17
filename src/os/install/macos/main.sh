#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
print_in_green "\n  ---\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./homebrew.sh
brew_update
brew_upgrade

print_in_green "\n  ---\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./bash.sh
print_in_green "\n  ---\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./misc.sh
print_in_green "\n  ---\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_cleanup
print_in_green "\n  ---\n\n"
