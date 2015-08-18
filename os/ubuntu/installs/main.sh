#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./update_and_upgrade.sh
    print_in_green '\n  ---\n\n'

    ./install_packages.sh
    print_in_green '\n  ---\n\n'

    ./update_and_upgrade.sh
    print_in_green '\n  ---\n\n'

    ./cleanup.sh

}

main
