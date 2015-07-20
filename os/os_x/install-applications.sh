#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./installs/xcode.sh

    ./installs/homebrew.sh
    print_in_green '\n  ---\n\n'

    ./installs/homebrew-formulae.sh
    print_in_green '\n  ---\n\n'

    ./installs/homebrew-versions-formulae.sh
    print_in_green '\n  ---\n\n'

    ./installs/homebrew-casks.sh
    print_in_green '\n  ---\n\n'

    ./installs/homebrew-alternate-casks.sh
    print_in_green '\n  ---\n\n'

    ./installs/homebrew-web-font-tools.sh
    print_in_green '\n  ---\n\n'

    execute 'brew cleanup' 'brew (cleanup)'

}

main
