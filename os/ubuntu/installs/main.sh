#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare OS_ARCH="$(get_os_arch)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    update
    upgrade

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Tools for compiling/building software from source
    install_package "Build Essential" "build-essential"

    # GnuPG archive keys of the Debian archive
    install_package "GnuPG archive keys" "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "atom"; then

        add_ppa "webupd8team/atom" \
            || print_error "Atom (add PPA)"

        update &> /dev/null \
            || print_error "Atom (resync package index files)"

    fi

    install_package "Atom" "atom"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "google-chrome-unstable"; then

        add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
            || print_error "Chrome Canary (add key)"

        add_to_source_list "http://dl.google.com/linux/deb/ stable main" "google-chrome.list" \
            || print_error "Chrome Canary (add to package resource list)"

        update &> /dev/null \
            || print_error "Chrome Canary (resync package index files)"

    fi

    install_package "Chrome Canary" "google-chrome-unstable"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Chromium" "chromium-browser"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Dropbox" "nautilus-dropbox"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "firefox-trunk"; then

        add_ppa "ubuntu-mozilla-daily/ppa" \
            || print_error "Firefox Nightly (add PPA)"

        update &> /dev/null \
            || print_error "Firefox Nightly (resync package index files)" \

    fi

    install_package "Firefox Nightly" "firefox-trunk"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Flash" "flashplugin-installer"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GIMP" "gimp"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GNOME Vim" "vim-gnome"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "ImageMagick" "imagemagick"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "opera"; then

        add_key "http://deb.opera.com/archive.key" \
            || print_error "Opera (add key)"

        add_to_source_list "http://deb.opera.com/opera-stable/ stable non-free" "opera.list" \
            || print_error "Opera (add to package resource list)"

        update &> /dev/null \
            || print_error "Opera (resync package index files)" \

    fi

    # Opera stable based on Blink is only
    # available for the 64-bit version of Ubuntu

    if [ "$OS_ARCH" == "64" ]; then

        # Automatically answer `Yes` to the `package configuration` prompt
        # https://github.com/alrra/dotfiles/issues/17

        printf "opera-stable opera-stable/add-deb-source boolean true\n" \
            | sudo debconf-set-selections

        install_package "Opera" "opera-stable"

    elif [ "$OS_ARCH" == "32" ]; then

        install_package "Opera" "opera"

    fi

    printf "opera-beta opera-beta/add-deb-source boolean true\n" \
        | sudo debconf-set-selections

    install_package "Opera Beta" "opera-beta"

    printf "opera-developer opera-developer/add-deb-source boolean true\n" \
        | sudo debconf-set-selections

    install_package "Opera Developer" "opera-developer"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "tmux" "tmux"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Transmission" "transmission"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "VirtualBox" "virtualbox"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "VLC" "vlc"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "xclip" "xclip"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Zopfli" "zopfli"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n  ---\n\n"
    update
    upgrade

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n  ---\n\n"
    autoremove

}

main
