#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   PHP\n\n"
brew_install "php" "php"

print_in_purple "\n   PHPMD\n\n"
brew_install "phpmd" "phpmd"

print_in_purple "\n   PHP Code Sniffer\n\n"
brew_install "php-code-sniffer" "php-code-sniffer"

print_in_purple "\n   PHP CS Fixer\n\n"
brew_install "php-cs-fixer" "php-cs-fixer"