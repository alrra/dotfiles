#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    # declare -r VIM_PACK_DIR="$HOME/.vim/pack"
    # declare -r MINPAC_DIR="$VIM_PACK_DIR/minpac/opt/minpac"
    # declare -r MINPAC_GIT_REPO_URL="https://github.com/k-takata/minpac.git"

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # # Install plugins.

    # execute \
    #     "rm -rf $VIM_PACK_DIR \
    #         && git clone --quiet $MINPAC_GIT_REPO_URL $MINPAC_DIR" \
    #     "Install plugins" \
    #     || return 1

    # vim +PluginsSetup

    declare -r VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"
    declare -r VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    declare -r VIM_BUNDLES_FILE="$HOME/.vimrc.bundles"

    if [ -e "$VIM_PLUG_PATH" ]; then
        vim -E -s +PlugUpgrade +qa
    else
        execute \
            "curl -fLo $VIM_PLUG_PATH --create-dirs $VIM_PLUG_URL" \
            "Install Plug" \
            || return 1
    fi

    if [ -e "$VIM_BUNDLES_FILE" ]; then
        execute \
            "vim -u $VIM_BUNDLES_FILE +PlugUpdate +PlugClean! +qa" \
            "Install plugins" \
            || return 1
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Vim\n\n"

    "./$(get_os)/vim.sh"
    install_plugins

}

main
