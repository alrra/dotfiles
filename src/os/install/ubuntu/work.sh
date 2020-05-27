#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1

}

install_aws() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"
    tmpDir="$(mktemp -d /tmp/XXXXX)"

    download "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" "$tmpFile" \
        && unzip -qq "$tmpFile" -d "$tmpDir" \
        && execute "sudo $tmpDir/aws/install --update" \
        && rm -rf "$tmpFile" \
        && rm -rf "$tmpDir" \
        && return 0

   return 1

}


print_in_purple "\n • Work\n\n"

execute "sudo snap install code --classic"
execute "sudo snap install slack --classic"
execute "sudo snap install zoom-client"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Docker\n\n"

install_package "Docker" "docker.io"

execute "sudo systemctl enable --now docker"

install_package "Docker-compose" "docker-compose"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Github Desktop\n\n"

execute "wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -"
execute "sudo sh -c 'echo \"deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main\" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'"
execute "sudo apt-get update"
install_package "Github Desktop" "github-desktop"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   awscli@2\n\n"
install_aws