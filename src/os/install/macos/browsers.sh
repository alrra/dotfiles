#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Browsers\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Chrome" "google-chrome" "--cask"
brew_install "Chrome Canary" "google-chrome-canary" "--cask" "homebrew/cask-versions"
brew_install "Chromium" "chromium" "--cask" "homebrew/cask-versions"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Firefox" "firefox" "--cask"
brew_install "Firefox Developer" "firefox-developer-edition" "--cask" "homebrew/cask-versions"
brew_install "Firefox Nightly" "firefox-nightly" "--cask" "homebrew/cask-versions"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `Safari Technology Preview` requires macOS 10.11.4 or la
# https://github.com/alrra/dotfiles/issues

if is_supported_version "$(get_os_version)" "10.11.4"; then
    printf "\n"
    brew_install "Safari Technology Preview" "safari-technology-preview" "--cask" "homebrew/cask-versions"
fi
