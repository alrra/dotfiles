#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh

reload_local_shell_configs
./bash.sh

./git.sh
./../volta.sh
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
