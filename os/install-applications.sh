#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r OS="$(get_os)"

    if [ "$OS" == "osx" ]; then
        ./os_x/install-applications.sh
        ./os_x/change-default-bash-version.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/install-applications.sh
    fi

}

main
