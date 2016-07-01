#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    declare -r VUNDLE_DIR="$HOME/.vim/plugins/Vundle.vim"
    declare -r VUNDLE_GIT_REPO_URL="https://github.com/gmarik/Vundle.vim.git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "rm -rf '$VUNDLE_DIR' \
            && git clone --quiet '$VUNDLE_GIT_REPO_URL' '$VUNDLE_DIR' \
            && printf '\n' | vim +PluginInstall +qall" \
        "Install Vim plugins"

}

install_additional_things() {

    # Additional installs
    # (required by some plugins)

    execute \
        "cd $HOME/.vim/plugins/tern_for_vim \
            && . $HOME/.bash.local \
            && npm install" \
        "Install extra parts for 'tern_for_vim'"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_info " Vim"

    install_plugins
    install_additional_things

}

main
