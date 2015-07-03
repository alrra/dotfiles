#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_key() {
    wget -qO - "$1" | sudo apt-key add - &> /dev/null
    #     │└─ write output to file
    #     └─ don't show output
}

add_ppa() {
    sudo add-apt-repository -y ppa:"$1" &> /dev/null
}

add_software_sources() {

    # Atom
    [ $(cmd_exists "atom") -eq 1 ] \
        && add_ppa "webupd8team/atom"

    # Firefox Nightly
    [ $(cmd_exists "firefox-trunk") -eq 1 ] \
        && add_ppa "ubuntu-mozilla-daily/ppa"

    # Google Chrome
    [ $(cmd_exists "google-chrome") -eq 1 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/deb/ stable main" \
                "google-chrome.list"

    # NodeJS
    [ $(cmd_exists "node") -eq 1 ] \
        && add_ppa "chris-lea/node.js"

    # Opera & Opera Next
    [ $(cmd_exists "opera") -eq 1 ] \
        && add_key "http://deb.opera.com/archive.key" \
        && add_source_list \
                "http://deb.opera.com/opera/ stable non-free" \
                "opera.list"

}

add_source_list() {
    sudo sh -c "printf 'deb $1' >> '/etc/apt/sources.list.d/$2'"
}

install_package() {

    declare -r PACKAGE="$2"
    declare -r PACKAGE_READABLE_NAME="$1"

    if ! package_is_installed "$PACKAGE"; then
        execute "sudo apt-get install --allow-unauthenticated -qqy $PACKAGE" "$PACKAGE_READABLE_NAME"
        #                                      suppress output ─┘│
        #            assume "yes" as the answer to all prompts ──┘
    else
        print_success "$PACKAGE_READABLE_NAME"
    fi

}

install_packages() {

    # Tools for compiling/building software from source
    install_package "Build Essential" "build-essential"

    # GnuPG archive keys of the Debian archive
    install_package "GnuPG archive keys" "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    # Other
    install_package "Atom" "atom"
    install_package "Chrome Canary" "google-chrome-unstable"
    install_package "Chromium" "chromium-browser"
    install_package "cURL" "curl"
    install_package "Dropbox" "nautilus-dropbox"
    install_package "Firefox" "firefox-trunk"
    install_package "Flash" "flashplugin-installer"
    install_package "GIMO" "gimp"
    install_package "Git" "git"
    install_package "GNOME Vim" "vim-gnome"
    install_package "ImageMagick" "imagemagick"
    install_package "Opera" "opera"
    install_package "Opera Next" "opera-next"
    install_package "tmux" "tmux"
    install_package "Transmission" "transmission"
    install_package "VirtualBox" "virtualbox"
    install_package "VLC" "vlc"
    install_package "xclip" "xclip"
    install_package "Zopfli" "zopfli"

}

package_is_installed() {
    dpkg -s "$1" &> /dev/null
    return $?
}

remove_unneeded_packages() {

    # Remove packages that were automatically installed to satisfy
    # dependencies for other other packages and are no longer needed
    execute "sudo apt-get autoremove -qqy" "autoremove"

}

update_and_upgrade() {

    # Resynchronize the package index files from their sources
    execute "sudo apt-get update -qqy" "update"

    # Unstall the newest versions of all packages installed
    execute "sudo apt-get upgrade -qqy" "upgrade"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local i=""

    add_software_sources

    update_and_upgrade
    printf "\n"

    install_packages
    printf "\n"

    update_and_upgrade
    remove_unneeded_packages

}

main
