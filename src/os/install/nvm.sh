#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_nvm_configs() {

    declare -r LOCAL_CONFIG_FILE="$HOME/.bash.local"
    declare -r NVM_DIRECTORY="$1"

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Node Version Manager

export NVM_DIR=\"$NVM_DIRECTORY\"

[ -f \"\$NVM_DIR/nvm.sh\" ] \\
    && . \"\$NVM_DIR/nvm.sh\"

[ -f \"\$NVM_DIR/bash_completion\" ] \\
    && . \"\$NVM_DIR/bash_completion\"
"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "printf '%s' '$CONFIGS' >> $LOCAL_CONFIG_FILE \
            && . $LOCAL_CONFIG_FILE" \
        "nvm (update $LOCAL_CONFIG_FILE)"

}

install_latest_stable_node() {

    # Install the latest stable version of Node.JS
    # (this will also set it as the default)

    execute "nvm install node" "nvm (install: node)"

}

install_nvm() {

    declare -r NVM_GIT_REPO_URL="https://github.com/creationix/nvm.git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install `nvm` and add the necessary configs to `~/.bash.local`

    execute "git clone --quiet $NVM_GIT_REPO_URL $NVM_DIRECTORY" "nvm" \
        && add_nvm_configs "$1"

}

update_nvm() {

    declare -r NVM_DIRECTORY="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "cd $NVM_DIRECTORY \
            && git fetch --quiet origin \
            && git checkout --quiet \$(git describe --abbrev=0 --tags) \
            && . $NVM_DIRECTORY/nvm.sh" \
        "nvm (upgrade)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r NVM_DIRECTORY="$HOME/.nvm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info " nvm"

    if [ ! -d "$NVM_DIRECTORY" ]; then
        install_nvm "$NVM_DIRECTORY"
    else
        update_nvm "$NVM_DIRECTORY"
    fi

    install_latest_stable_node

}

main
