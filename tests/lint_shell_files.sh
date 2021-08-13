#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

find \
    ../src/os \
    ../src/shell \
    ../tests/*.sh \
    -type f \
    ! -path '../src/os/preferences/macos/*.applescript' \
    ! -path '../src/os/preferences/macos/*.terminal' \
    ! -path '../src/shell/curlrc' \
    ! -path '../src/shell/inputrc' \
    -exec shellcheck \
            --exclude=SC1090 \
            --exclude=SC1091 \
            --exclude=SC2155 \
            --exclude=SC2164 \
    {} +
