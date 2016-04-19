#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r OS="$(get_os)"

    print_warning "This may take awhile, so please be patient!\n"

    if [ "$OS" == "osx" ]; then
        ./os_x/installs/main.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/installs/main.sh
    fi

}

main
