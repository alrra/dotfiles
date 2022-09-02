#!/bin/bash

# Ensure the following is executed as if this script was
# in the project root.
#
# Note: The main reason for doing this is to simplify the
#       output and also have it relative to the project root.

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

find \
    src/os \
    src/shell \
    scripts/**/*.sh \
    -type f \
    ! -path 'src/**/*.applescript' \
    ! -path 'src/**/*.terminal' \
    ! -path 'src/shell/curlrc' \
    ! -path 'src/shell/inputrc' \
    -exec shellcheck \
            --exclude=SC1090 \
            --exclude=SC1091 \
            --exclude=SC2155 \
            --exclude=SC2164 \
    {} +
