#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r OS="$(get_os)"

    if [ "$OS" == 'osx' ]; then

        ./os_x/installs/main.sh
        ./os_x/change_default_bash_version.sh

    elif [ "$OS" == 'ubuntu' ]; then

        ./ubuntu/installs/main.sh

    fi

}

main
