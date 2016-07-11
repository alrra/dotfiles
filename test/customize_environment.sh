#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Linux

if [ "$TRAVIS_OS_NAME" = "linux" ]; then

    # The Travis CI Ubuntu Trusty images do not
    # have the some of the suites enabled by default.

    sudo add-apt-repository multiverse
    sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ trusty-backports restricted main universe"
    sudo apt-get update -qqy

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install `ShellCheck`
    # (required for testing).

    sudo apt-get install -qqy shellcheck

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# OS X

elif [ "$TRAVIS_OS_NAME" = "osx" ]; then

    # Install `ShellCheck`
    # (required for testing).

    brew install shellcheck

fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# To better simulate a clean OS install, remove certain things
# included by default by Travis CI.

rm -rf "$NVM_DIR"
