#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Remove packages that were automatically installed to satisfy
    # dependencies for other other packages and are no longer needed

    execute 'sudo apt-get autoremove -qqy' 'Autoremove'

}

main
