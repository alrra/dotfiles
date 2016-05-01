#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local OS=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    OS="$(get_os)"

    print_warning "This may take awhile, so please be patient!\n"

    if [ "$OS" == "osx" ]; then
        ./os_x/installs/main.sh
    elif [ "$OS" == "ubuntu" ]; then
        ./ubuntu/installs/main.sh
    fi

}

main
