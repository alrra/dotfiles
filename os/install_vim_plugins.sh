#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if [ $(cmd_exists "git") -eq 0 ]; then

        rm -rf ~/.vim/plugins/Vundle.vim &> /dev/null \
            && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/plugins/Vundle.vim &> /dev/null \
            && printf "\n" | vim +PluginInstall +qall 2> /dev/null
            #     └─ simulate the ENTER keypress for
            #        the case where there are warnings

        print_result $? "Install Vim plugins"

    else
        print_error "Git is required, please install it!\n"
    fi

}

main
