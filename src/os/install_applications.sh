#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local os=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    os="$(get_os)" \
        || print_error "Failed to get the kernel name"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_warning "This may take awhile, so please be patient!\n"

    if [ "$os" == "macos" ]; then
        ./macos/installs/main.sh
    elif [ "$os" == "ubuntu" ]; then
        ./ubuntu/installs/main.sh
    fi

}

main
