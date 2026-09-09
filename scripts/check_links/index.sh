#!/bin/bash

# Ensure the following is executed as if this script was in
# the project root.
#
# Note: The main reason for doing this is to simplify the
#       output and also have it relative to the project root.

cd "$(dirname "${BASH_SOURCE[0]}")/../.." \
    && . "./scripts/utils/check_markdown_files.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

check_links() (
    npx --yes \
        markdown-link-check@3.15.0 \
            --config ./scripts/check_links/configs.json \
            --retry \
                "$1"
)

check_markdown_files \
    "." \
    check_links
