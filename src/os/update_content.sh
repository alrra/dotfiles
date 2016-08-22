#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ssh -T git@github.com &> /dev/null

    if [ $? -ne 2 ]; then
        ./set_github_ssh_key.sh
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ $? -eq 0 ]; then

        print_in_purple "\n Update content\n\n"

        execute \
            "git fetch --all \
                && git reset --hard origin/master \
                && git clean -fd" \
            "Update content"

    fi

}

main
