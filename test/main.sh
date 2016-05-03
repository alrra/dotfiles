#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if [ "$TRAVIS_OS_NAME" == "osx" ]; then
        ./run_shellcheck.sh
    elif [ "$TRAVIS_OS_NAME" == "linux" ]; then
        printf "\n"
    fi

}

main
