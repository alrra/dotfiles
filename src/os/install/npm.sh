#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_npm_package() {

    execute \
        ". $HOME/.bash.local \
            && npm install --global --silent $2" \
        "$1"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   npm\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "npm (update)" "npm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    install_npm_package "Instant-markdown" "instant-markdown-d"
    install_npm_package "Babel" "babel-cli"
    install_npm_package "JSHint" "jshint"
    install_npm_package "Gulp" "gulp-cli"
    install_npm_package "Babel ESLint" "babel-eslint"
    install_npm_package "Fancy Diff" "diff-so-fancy"
    install_npm_package "ESLint" "eslint"
    install_npm_package "ESLint Config Airbnb" "eslint-config-airbnb"
    install_npm_package "ESLint Config Airbnb Base" "eslint-config-airbnb-base"
    install_npm_package "ESLint Plugin Import" "eslint-plugin-import"
    install_npm_package "ESLint Plugin JSX A11y" "eslint-plugin-jsx-a11y"
    install_npm_package "ESLint Plugin React" "eslint-plugin-react"
    install_npm_package "Git Open" "git-open"
    install_npm_package "Git Recent" "git-recent"
    install_npm_package "Trash CLI" "trash-cli"
    install_npm_package "Spacehogs" "space-hogs"
    install_npm_package "TLDR" "tldr"
    install_npm_package "VMD" "vmd"
    install_npm_package "VTOP" "vtop"
    install_npm_package "Wallpaper" "wallpaper-cli"
    install_npm_package "WhatToDo" "whattodo"
    install_npm_package "WiFi Password" "wifi-password-cli"
    install_npm_package "Fast" "fast-cli"
    install_npm_package "Firebase Tools" "firebase-tools"
    install_npm_package "Fabulous Kill" "fkill-cli"
    install_npm_package "Express Generator" "express-generator"
}

main
