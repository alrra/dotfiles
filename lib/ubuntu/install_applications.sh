#!/bin/bash

declare -a APT_PACKAGES=(

    # Tools for compiling/building software from source
    "build-essential"

    # GnuPG archive keys of the Debian archive
    "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #"ubuntu-restricted-extras"

    "chromium-browser"
    "curl"
    "nautilus-dropbox"
    "firefox-trunk"
    "gimp"
    "git"
    "google-chrome-unstable"
    "google-talkplugin"
    "nodejs"
    "npm"
    "opera"
    "opera-next"
    "vim-gnome"
    "vlc"
)

# ##############################################################################
# # HELPER FUNCTIONS                                                           #
# ##############################################################################

add_key() {
    wget -qO - "$1" | sudo apt-key add - > /dev/null
}

add_ppa() {
    sudo add-apt-repository -y ppa:"$1" > /dev/null
}

add_source_list() {
    sudo sh -c "printf 'deb $1' >> '/etc/apt/sources.list.d/$2'"
}

install_pkg() {
    local q="${2:-$1}"

    [ $(cmd_exists "$q") -eq 1 ] \
      && execute_str "sudo apt-get install --allow-unauthenticated -qqy $1" "$1"
    #                                                  suppress output ─┘│
    #                        assume "yes" as the answer to all prompts ──┘
}

remove_unneeded_pkgs() {
    execute_str "sudo apt-get autoremove -qqy" "autoremove"
    #                             └─ remove packages that were automatically
    #                                installed to satisfy dependencies for other
    #                                other packages and are no longer needed
}

update_and_upgrade() {
    sudo apt-get update -qqy
    #              └─ resynchronize the package index files from their sources
    sudo apt-get upgrade -qqy
    #              └─ install the newest versions of all packages installed
}

install_applications() {

    local dest="", i="", src="", tmp=""

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

    # Google Talk Plugin
    [ $(cmd_exists "/opt/google/talkplugin/GoogleTalkPlugin") -eq 1 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/talkplugin/deb/ stable main" \
                "google-talkplugin.list"

    # NodeJS
    [ $(cmd_exists "node") -eq 1 ] \
        && add_ppa "chris-lea/node.js"

    # Opera & Opera Next
    [ $(cmd_exists "opera") -eq 1 ] \
        && add_key "http://deb.opera.com/archive.key" \
        && add_source_list \
                "http://deb.opera.com/opera/ stable non-free" \
                "opera.list"

    execute "update_and_upgrade" "update & upgrade"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


    # Tools for compiling / building software from source
    install_pkg "build-essential"

    # GnuPG archive keys of the Debian archive
    install_pkg "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #install_pkg "ubuntu-restricted-extras"

    install_pkg "chromium-browser"
    install_pkg "curl"
    install_pkg "nautilus-dropbox" "dropbox"
    install_pkg "firefox-trunk"
    install_pkg "gimp"
    install_pkg "git"
    install_pkg "google-chrome-unstable" "google-chrome"
    install_pkg "google-talkplugin" "/opt/google/talkplugin/GoogleTalkPlugin"
    install_pkg "nodejs" "node"
    install_pkg "npm"
    install_pkg "opera"
    install_pkg "opera-next"
    install_pkg "vim-gnome" "vim"
    install_pkg "vlc"

}


log_info "Installing applications..."
install_applications


    log_info "Clean up"

    execute "update_and_upgrade" "update & upgrade"
    execute "remove_unneeded_pkgs" "autoremove"

