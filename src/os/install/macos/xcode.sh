#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

agree_with_xcode_licence() {

    # Automatically agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    execute \
        "sudo xcodebuild -license accept" \
        "Agree to the terms of the XCode Command Line Tools licence"

}

install_xcode() {

    # Prompt user to install the XCode Command Line Tools

    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed

    until is_xcode_installed; do
        sleep 5
    done

    print_result $? "XCode Command Line Tools"

}

is_xcode_installed() {
    xcode-select --print-path &> /dev/null
}

set_xcode_developer_directory() {

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    execute \
        "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer" \
        "Make 'xcode-select' developer directory point to Xcode"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_info " XCode"

    install_xcode
    set_xcode_developer_directory
    agree_with_xcode_licence

}

main
