#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.TextEdit PlainTextEncoding -int 4 &&
             defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4" \
        "Open and save files as UTF-8 encoded"

    execute "defaults write com.apple.TextEdit RichText -" \
        "Use plain text mode for new documents"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  TextEdit\n\n"
    set_preferences

    killall "TextEdit" &> /dev/null

}

main
