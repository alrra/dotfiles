#!/bin/bash

# Bash Variables.
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make `vim` the default editor.

export EDITOR="vim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ignore commands that start with spaces and duplicates.

export HISTCONTROL=ignoreboth

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of lines of history
# persisted in the history file (default value is 500).

export HISTFILESIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't add certain commands to the history file.

export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of commands recorded
# in the command history (default value is 500).

export HISTSIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Prefer US English and use UTF-8 encoding.

export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use custom `less` colors for `man` pages.

export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't clear the screen after quitting a `man` page.

export MANPAGER="less -X"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of lines of history persisted
# in the `Node` REPL history file (default value is 1000).
#
# https://github.com/nodejs/node/blob/c948877688ff2b6a37f2c88724b656aae495c7b2/doc/api/repl.md#persistent-history

export NODE_REPL_HISTORY_SIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make Python use UTF-8 encoding for output to stdin/stdout/stderr.

export PYTHONIOENCODING="UTF-8"
