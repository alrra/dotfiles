#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_to_path() {
    # Check if `brew` is available.

    if command -v brew &> /dev/null; then
        return
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If not, add it to the PATH.

    local HARDWARE="$(uname -m)"
    local brewPrefix=""

    if [ "$HARDWARE" = "arm64" ]; then
        brewPrefix="/opt/homebrew"
    elif [ "$HARDWARE" = "x86_64" ]; then
        brewPrefix="/usr/local"
    else
        print_error "Homebrew is only supported on Intel and ARM processors!"
    fi

    update_local_shell_configs "export PATH=\"$brewPrefix/bin:\$PATH\" # Homebrew"
}

install() {
    if ! cmd_exists "brew"; then
        ask_for_sudo
        printf "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi

    print_result $? "Install"
}

opt_out_of_analytics() {
    execute \
        "brew analytics off" \
        "Opt-out of analytics"
}

update() {
    execute \
        "brew update" \
        "Update"
}

upgrade() {
    execute \
        "brew upgrade" \
        "Upgrade"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   Homebrew\n\n"

    install
    add_to_path
    opt_out_of_analytics

    update
    upgrade
}

main
