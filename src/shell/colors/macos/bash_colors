#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set LSCOLORS (FreeBSD / macOS).
#
#  * `ls` displays colors if the `-G` option is passed or if
#    the `CLICOLOR` environment variable is set.
#
#  * The actual colors are configured through the `LSCOLORS`
#    environment variable (built-in defaults are used if this
#    variable is not set).

LSCOLORS=""

LSCOLORS+="gx" # Directory
LSCOLORS+="fx" # Symbolic link
LSCOLORS+="cx" # Socket
LSCOLORS+="dx" # Pipe
LSCOLORS+="cx" # Executable
LSCOLORS+="eg" # Block special
LSCOLORS+="ed" # Character special
LSCOLORS+="ab" # Executable with setuid bit set
LSCOLORS+="ag" # Executable with setgid bit set
LSCOLORS+="cc" # Directory writable to others, with sticky bit
LSCOLORS+="bd" # Directory writable to others, without sticky bit

export LSCOLORS

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Enable color support.

alias ls="ls -G"
