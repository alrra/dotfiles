#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if `Git` is installed
    if [ $(cmd_exists "git") -eq 1 ]; then
        print_error "Git is required, please install it!\n"
        exit
    fi

    rm -rf ~/.vim/plugins/Vundle.vim &> /dev/null \
        && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/plugins/Vundle.vim &> /dev/null \
        && printf "\n" | vim +PluginInstall +qall 2> /dev/null
        #     └─ simulate the ENTER keypress for
        #        the case where there are warnings

    print_result $? "Install Vim plugins"

}

main
