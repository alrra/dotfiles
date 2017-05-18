#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Utilities\n\n"

brew_install "MacDown" "macdown" "caskroom/cask" "cask"
brew_install "Pathfinder" "path-finder" "caskroom/cask" "cask"
brew_install "1Password" "1password" "caskroom/cask" "cask"
brew_install "Alfred" "alfred" "caskroom/cask" "cask"
brew_install "App Cleaner" "appcleaner" "caskroom/cask" "cask"
brew_install "Bartender" "bartender" "caskroom/cask" "cask"
brew_install "Etre Check" "etrecheck" "caskroom/cask" "cask"
brew_install "KnockKnock" "knockknock" "caskroom/cask" "cask"
brew_install "Evernote" "evernote" "caskroom/cask" "cask"
brew_install "OmniFocus" "omnifocus" "caskroom/cask" "cask"
brew_install "Sketch" "sketch" "caskroom/cask" "cask"
brew_install "Slack" "slack" "caskroom/cask" "cask"
brew_install "iTerm2" "iterm2" "caskroom/cask" "cask"