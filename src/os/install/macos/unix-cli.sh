#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UNIX Command Line Utils\n\n"

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew_install "GNU Core Utilities" "coreutils"
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew_install "GNU More Utilities" "moreutils"
brew_install "GNU Find Utilities" "findutils"
brew_install "GNU sed" "gnu-sed --with-default-names"

