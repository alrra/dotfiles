#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Work\n\n"

install_package "Docker" "docker.io"

execute "sudo systemctl enable --now docker"

install_package "Docker-compose" "docker-compose"
