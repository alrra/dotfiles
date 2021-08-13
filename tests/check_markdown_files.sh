#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Executes provided function on each found Markdown file.
#
# $1: Function to be executed.
#
# Returns with an exit status of 0 if the provided function
# succeeded for all Markdown files, 1 otherwise.

check_markdown_files() {

    if ! cmd_exists "npx"; then
        print_error "'npx' command is not available."
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    local MARKDOWN_FILES=$( \
        find .. \
            -name "*.md" \
            -not -path "../node_modules/*" \
            -not -path "../src/vim/vim/*"
    );

    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for file in $MARKDOWN_FILES; do
        "$1" "$file" \
            || exitCode=1
    done

    return $exitCode

}
