#!/bin/bash

# Ensure the following is executed as if this script was
# in the project root.
#
# Note: The main reason for doing this is to simplify the
#       output and also have it relative to the project root.

cd "$(dirname "${BASH_SOURCE[0]}")/../.." \
    && . "./scripts/utils/check_markdown_files.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

lint() (
    npx markdownlint-cli@^0.37 "$1"
)

check_markdown_files \
    "." \
    lint
