#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

check_links() {

    local MARKDOWN_FILES=$( \
        find .. \
            -name "*.md" \
            -not -path "../node_modules/*" \
            -not -path "../src/vim/vim/*"
    );

    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for file in $MARKDOWN_FILES; do
        npx markdown-link-check --quiet --retry "$file" \
            || exitCode=1
    done

    return $exitCode

}

main() {

    if ! cmd_exists "npx"; then
        print_error "'npx' command is not available."
        return 1
    fi

    check_links

}

main
