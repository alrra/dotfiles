#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Resynchronize the package index files from their sources
    execute 'sudo apt-get update -qqy' 'update'

    # Install the newest versions of all packages installed
    execute 'sudo apt-get upgrade -qqy' 'upgrade'

}

main
