#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./bash.sh

./git.sh
./../nvm.sh
./browsers.sh
./compression_tools.sh
./gpg.sh
./image_tools.sh
./misc.sh
./misc_tools.sh
./../npm.sh
./tmux.sh
./video_tools.sh
./../vim.sh
./vscode.sh
./web_font_tools.sh
