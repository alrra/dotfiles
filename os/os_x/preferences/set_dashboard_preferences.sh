#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
        "Disable Dashboard"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Dashboard\n\n"
    set_preferences


    # 'killall Dashboard' doesn't actually do anything. To apply
    # the changes for Dashboard, 'killall Dock' is enough as Dock
    # is Dashboard's parent process.

    killall "Dock" &> /dev/null

}

main
