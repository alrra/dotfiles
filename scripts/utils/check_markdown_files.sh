#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Executes provided function on each found Markdown file.
#
# $1: Path from which to start searching for Markdown files.
# $2: Function to be executed.
#
# Returns with an exit status of:
#
#  * 0 if the provided function succeeded for all Markdown files
#  * 1 otherwise.

check_markdown_files() {

    if ! command -v "npx" &> /dev/null; then
        printf "'npx' command is not available."
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    local MARKDOWN_FILES=$( \
        find "$1" \
            -name "*.md" \
            -not -path "**/node_modules/*" \
            -not -path "**/vim/vim/*"
    );

    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for file in $MARKDOWN_FILES; do
        "$2" "$file" \
            || exitCode=1
    done

    return $exitCode

}
