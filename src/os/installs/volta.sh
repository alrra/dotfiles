#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_configs() {

    # Check if the configs need to be added.

    . "$LOCAL_SHELL_CONFIG_FILE"

    if command -v volta &> /dev/null; then
        return
    fi

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Volta

export PATH=\"\$HOME/.volta/bin:\$PATH\"
"

    execute \
        "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE" \
        "Update $LOCAL_SHELL_CONFIG_FILE"

}

install() {
    execute \
        "curl https://get.volta.sh | bash -s -- --skip-setup" \
        "Install"
}

install_node() {

    # Install Node.js LTS.
    # Note: This will also set it as the default.

    execute \
        ". $LOCAL_SHELL_CONFIG_FILE && \
           volta install node" \
        "Install Node.js LTS"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Volta\n\n"

    install
    add_configs
    install_node

}

main
