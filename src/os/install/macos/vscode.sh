#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension --force $1" "$2 (plugin)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code\n\n"                                :

# Install VSCode
brew_install "Visual Studio Code" "visual-studio-code" "homebrew/cask" "cask"

printf "\n"

# Install the VSCode plugins
install_plugin "DavidAnson.vscode-markdownlint" "MarkdownLint"
install_plugin "EditorConfig.EditorConfig" "EditorConfig"
install_plugin "vscodevim.vim" "Vim"

# Close VSCode
kill -9 "$(pgrep Electron)"
