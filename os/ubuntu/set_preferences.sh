#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./preferences/privacy.sh
    ./preferences/terminal.sh
    ./preferences/ui-and-ux.sh

}

main
