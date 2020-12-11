#!/bin/bash

set -e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare tmpDir="$(mktemp --directory)"

# Use external script to set the Solarized color set.
git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git "$tmpDir"
cd "$tmpDir"

# Ensured the right (reviewed) script is executed.
git checkout -b main 9651c41df0f89e87feee0c798779abba0f9395e0

# Run script and automatically respond to all prompts
printf "1\nYES\n" | ./set_dark.sh

# Clean up.
rm -rf "$tmpDir"
