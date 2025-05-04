#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check if the terminal has "Full Disk Access", and if it does
# not, ask the user to grant it.
#
# This is required in order to be able to set some preferences.
# See also: https://lapcatsoftware.com/articles/containers.html.

if ! ls "$HOME/Library/Containers/com.apple.Safari/Data" &> /dev/null; then
    printf "\n"

    # Open the "Full Disk Access" system preferences.
    open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"

    # Ask the user to grant "Full Disk Access".
    ask "Please grant the terminal \"Full Disk Access\" and then press any key to continue. "
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open "System Preferences" panes in order to
# avoid overriding the preferences that are being changed.

./close_system_preferences_panes.applescript
