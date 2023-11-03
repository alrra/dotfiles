#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous Tools\n\n"

brew_install "eyeD3" "eye-d3"
brew_install "pdfcpu" "pdfcpu"
brew_install "ShellCheck" "shellcheck"
brew_install "Yarn" "yarn"
