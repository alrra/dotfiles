#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

update
upgrade

./build-essentials.sh

./git.sh
./browsers.sh
./compression_tools.sh
./image_tools.sh
./misc.sh
./misc_tools.sh
./../volta.sh
./../npm.sh
./tmux.sh
./../vim.sh

./cleanup.sh
