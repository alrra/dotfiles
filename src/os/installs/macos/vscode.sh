#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension $2" "$1 plugin"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code\n\n"

# Install VSCode
brew_install "Visual Studio Code" "visual-studio-code" "--cask"

printf "\n"

# Install the VSCode plugins
install_plugin "EditorConfig" "EditorConfig.EditorConfig"
install_plugin "File Icons" "vscode-icons-team.vscode-icons"
install_plugin "MarkdownLint" "DavidAnson.vscode-markdownlint"
install_plugin "Vim" "vscodevim.vim"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
