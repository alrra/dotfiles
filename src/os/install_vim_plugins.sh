#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r VUNDLE_DIR="$HOME/.vim/plugins/Vundle.vim"
    declare -r VUNDLE_GIT_REPO_URL="https://github.com/gmarik/Vundle.vim.git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install / Update vim plugins

    execute \
        "rm -rf '$VUNDLE_DIR' \
            && git clone --quiet '$VUNDLE_GIT_REPO_URL' '$VUNDLE_DIR' \
            && printf '\n' | vim +PluginInstall +qall" \
        "Install Vim plugins"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # In the case of fresh installs, in order for `npm` to be
    # available, the `~/bash.local` file needs to be sourced

    if ! cmd_exists "npm"; then
        source "$HOME/.bash.local"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Additional installs

    execute \
        "cd $HOME/.vim/plugins/tern_for_vim \
            && npm install" \
        "Install extra parts for 'tern_for_vim'"

}

main
