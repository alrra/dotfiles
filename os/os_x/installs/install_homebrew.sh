#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local HOMEBREW_GIT_CONFIG_FILE=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! cmd_exists "brew"; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi

    print_result $? "Homebrew"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If something when wrong so far, don't continue any further

    [ $? -ne 0 ] \
        && exit 0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics
    # https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out

    HOMEBREW_GIT_CONFIG_FILE="$(brew --repository)/.git/config"

    if [ "$(git config --file="$HOMEBREW_GIT_CONFIG_FILE" --get homebrew.analyticsdisabled)" != "true" ]; then
        git config --file="$HOMEBREW_GIT_CONFIG_FILE" --replace-all homebrew.analyticsdisabled true &> /dev/null
    fi

    print_result $? "Homebrew (opt-out of analytics)"

}

main
