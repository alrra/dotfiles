#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   LastPass\n\n"

install_package "LastPass" "lastpass-cli"

execute "lpass status -q"

if [ $? -eq 0 ]
then
  print_in_green "\n   Logged in\n\n"
else
  declare privateEmail=""
    while [ -z "$privateEmail" ]; do
        ask "Please enter your private email address: "
        privateEmail="$(get_answer)"
    done

    execute "lpass login --trust '$privateEmail'"
fi

