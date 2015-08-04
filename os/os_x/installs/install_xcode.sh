#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../../utils.sh' \
    && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if ! xcode-select -p &> /dev/null; then

        # Prompt user to install the XCode Command Line Tools
        xcode-select --install &> /dev/null

        # Wait until the XCode Command Line Tools are installed
        while ! xcode-select -p &> /dev/null; do
            sleep 5
        done

        print_result $? 'Install XCode Command Line Tools'

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Prompt user to agree to the terms of the Xcode license
        # https://github.com/alrra/dotfiles/issues/10

        sudo xcodebuild -license
        print_result $? 'Agree with the XCode Command Line Tools licence'

    fi

    print_result $? 'XCode Command Line Tools'

}

main
