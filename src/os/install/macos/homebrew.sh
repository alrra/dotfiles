#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local homebrewGitConfigFilePath=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! cmd_exists "brew"; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi

    print_result $? "brew" \
        || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Homebrew` git config file,
    # and if something fails, don't continue any further

    homebrewGitConfigFilePath="$(brew --repository 2> /dev/null)/.git/config"

    if [ $? -ne 0 ]; then
        print_error "brew (get config file path)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics
    # https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out

    if [ "$(git config --file="$homebrewGitConfigFilePath" --get homebrew.analyticsdisabled)" != "true" ]; then
        git config --file="$homebrewGitConfigFilePath" --replace-all homebrew.analyticsdisabled true &> /dev/null
    fi

    print_result $? "brew (opt-out of analytics)"

}

main
