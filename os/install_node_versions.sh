#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

declare -r -a NODE_VERSIONS=(
    "node"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r NVM_DIRECTORY="$HOME/.nvm"
    declare -r CONFIGS='
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Node Version Manager

export NVM_DIR="'$NVM_DIRECTORY'"
[ -f "$NVM_DIR/nvm.sh" ] \
    && source "$NVM_DIR/nvm.sh"

[ -f "$NVM_DIR/bash_completion" ] \
    && source $NVM_DIR/bash_completion
'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install `nvm` and add the necessary configs to `~/.bash.local`

    if [ ! -d "$NVM_DIRECTORY" ]; then

        git clone https://github.com/creationix/nvm.git "$NVM_DIRECTORY" &> /dev/null
        print_result $? "nvm"

        if [ $? -eq 0 ]; then
            printf "%s" "$CONFIGS" >> "$HOME/.bash.local" \
                && source "$HOME/.bash.local"
            print_result $? "nvm (update ~/.bash.local)"
        fi

    fi

    if [ -d "$NVM_DIRECTORY" ]; then

        # Ensure the latest version of `nvm` is used
        cd "$NVM_DIRECTORY" \
            && git checkout `git describe --abbrev=0 --tags` &> /dev/null
        print_result $? "nvm (update)"

        source "$NVM_DIRECTORY/nvm.sh"

        # Install node versions
        for i in ${NODE_VERSIONS[@]}; do
            execute "nvm install $i" "nvm (install: $i)"
        done

        # Use `Node.js` by default
        execute "nvm alias default node" "nvm (set default)"

    fi

}

main
