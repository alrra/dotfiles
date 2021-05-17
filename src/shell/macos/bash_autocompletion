#!/bin/bash

if command -v brew &> /dev/null; then

    declare BASH_COMPLETION_PATH="$(brew --prefix 2> /dev/null)/etc/profile.d/bash_completion.sh"

    if [ -r "$BASH_COMPLETION_PATH" ]; then

        # Ensure existing `bash-completion@1` continues to work.
        # https://github.com/Homebrew/homebrew-core/pull/36254

        export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Use the latest `bash-completion`.

        . "$BASH_COMPLETION_PATH"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Make Bash complete the `g` alias just like it does `git`.

        __git_complete g git

    fi

elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion;
fi
