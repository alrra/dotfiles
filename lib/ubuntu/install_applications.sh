#!/bin/bash

declare -a APT_PACKAGES=(

    # Tools for compiling/building software from source
    "build-essential"

    # GnuPG archive keys of the Debian archive
    "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #"ubuntu-restricted-extras"

    # Other
    "chromium-browser"
    "curl"
    "nautilus-dropbox"
    "firefox-trunk"
    "flashplugin-installer"
    "gimp"
    "git"
    "google-chrome-unstable"
    "imagemagick"
    "nodejs"
    "npm"
    "opera"
    "opera-next"
    "transmission"
    "vim-gnome"
    "virtualbox"
    "vlc"
    "xclip"
    "zopfli"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_key() {
    wget -qO - "$1" | sudo apt-key add - &> /dev/null
    #     │└─ write output to file
    #     └─ don't show output
}

add_ppa() {
    sudo add-apt-repository -y ppa:"$1" &> /dev/null
}

add_source_list() {
    sudo sh -c "printf 'deb $1' >> '/etc/apt/sources.list.d/$2'"
}

install_package() {
    local q="${2:-$1}"

    if [ $(cmd_exists "$q") -eq 1 ]; then
        execute "sudo apt-get install --allow-unauthenticated -qqy $1" "$1"
        #                                      suppress output ─┘│
        #            assume "yes" as the answer to all prompts ──┘
    fi
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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_applications() {

    local i="", tmp=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add software sources

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

    update_and_upgrade

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in ${!APT_PACKAGES[*]}; do
        install_package "${APT_PACKAGES[$i]}"
    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    update_and_upgrade
    remove_unneeded_packages

}
