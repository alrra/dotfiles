#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./check_markdown_files.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

lint() {
    npx markdownlint-cli --fix "$1"
}

check_markdown_files lint
