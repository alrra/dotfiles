#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -r -a NODE_VERSIONS=(
    "iojs"
    "node"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r NVM_DIR="$HOME/.nvm"
    declare -r CONFIGS='
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Node Version Manager

export NVM_DIR="'$NVM_DIR'"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed
    if [ $(cmd_exists "git") -eq 1 ]; then
        print_error "Git is required, please install it!\n"
        exit
    fi

    # Install `npm` and add the necessary configs to `~/.bash.local`
    if [ ! -d "$NVM_DIR" ]; then

        git clone https://github.com/creationix/nvm.git "$NVM_DIR" &> /dev/null
        print_result $? "nvm"

        printf "%s" "$CONFIGS" >> "$HOME/.bash.local"
        print_result $? "nvm (update ~/.bash.local)"

    fi

    if [ -d "$NVM_DIR" ]; then

        # Ensure the latest version of `nvm` is used
        cd "$NVM_DIR" \
            && git checkout `git describe --abbrev=0 --tags` &> /dev/null
        print_result $? "nvm (update)"

        source "$NVM_DIR/nvm.sh"

        # Install node versions
        for i in ${NODE_VERSIONS[@]}; do
            execute "nvm install $i" "nvm (install $i)"
        done

        # Use `io.js` by default
        execute "nvm alias default iojs" "nvm (set default)"

    fi

}

main
