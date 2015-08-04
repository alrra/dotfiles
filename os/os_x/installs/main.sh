#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./install_xcode.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew_formulae.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew_versions_formulae.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew_casks.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew_alternate_casks.sh
    print_in_green '\n  ---\n\n'

    ./install_homebrew_web_font_tools.sh
    print_in_green '\n  ---\n\n'

    ./update_and_upgrade.sh
    print_in_green '\n  ---\n\n'

    ./cleanup.sh

}

main
