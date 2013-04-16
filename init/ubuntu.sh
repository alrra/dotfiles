#!/bin/bash

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

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 1 \
        || printf 0
}

execute_str() {
    sudo sh -c "$1" > /dev/null
    print_result $? "$2"
}

execute() {
    $1 > /dev/null
    print_result $? "$2"
}

install_pkg() {
    local q="${2:-$1}"

    [ $(cmd_exists "$q") -eq 0 ] \
      && execute_str "sudo apt-get install --allow-unauthenticated -qqy $1" "$1"
    #                                                  suppress output ─┘│
    #                        assume "yes" as the answer to all prompts ──┘
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 [a file with the same name already exists]"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    printf "\e[1;31m  ✖ $1 $2\e[0m\n"
}

print_info() {
    printf "\n\e[1;33m $1\e[0m\n\n"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"
}

print_success() {
    printf "\e[1;32m  ✔ $1\e[0m\n"
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

# ##############################################################################
# # SETTINGS FUNCTIONS                                                         #
# ##############################################################################

# ------------------------------------------------------------------------------
# | Appearance                                                                 |
# ------------------------------------------------------------------------------

set_appearance_settings() {

    # Autohide the Launcher
    gsettings set com.canonical.Unity2d.Launcher hide-mode 1

    # Set desktop background image location and options
    gsettings set org.gnome.desktop.background picture-options "stretched"
    #gsettings set org.gnome.desktop.background picture-uri "file:///home/..."

    # Set `Left Side` as the reveal location for the Launcher
    gsettings set com.canonical.Unity2d.Launcher reveal-mode 0

    # Set Launcher favorites
    gsettings set com.canonical.Unity.Launcher favorites "[
        'ubiquity-gtkui.desktop',
        'nautilus-home.desktop',
        'chromium-browser.desktop',
        'google-chrome.desktop',
        'firefox.desktop',
        'firefox-trunk.desktop',
        'opera-browser.desktop',
        'opera-next-browser.desktop'
    ]"

}

# ------------------------------------------------------------------------------
# | UI/UX                                                                      |
# ------------------------------------------------------------------------------

set_ui_and_ux_settings() {

    # Hide the Battery icon from the menu bar when the battery is not in use
    gsettings set com.canonical.indicator.power icon-policy "charge"
    gsettings set com.canonical.indicator.power show-time false

    # Hide the Bluetooth and Volume icons from the menu bar
    gsettings set com.canonical.indicator.bluetooth visible false
    gsettings set com.canonical.indicator.sound visible false

    # Set keyboard languages and show the Language icon in menu bar
    gsettings set org.gnome.libgnomekbd.keyboard layouts "[ 'us', 'ro' ]"

    # Use custom date format in the menu bar
    # (other date interpreted sequences: date --help)
    gsettings set com.canonical.indicator.datetime custom-time-format "%l:%M %p"
    gsettings set com.canonical.indicator.datetime time-format "custom"

}

# ##############################################################################
# # MAIN                                                                       #
# ##############################################################################

main() {

    # Ensure the OS is Ubuntu
    if [ "$(uname -s)" != "Linux" ] || [ ! -e "/etc/lsb-release" ]; then
        print_error "Sorry, this script is for Ubuntu only!"
        exit
    fi

    # --------------------------------------------------------------------------
    # | Init                                                                   |
    # --------------------------------------------------------------------------

    declare dest=""
    declare i=""
    declare tmp=""
    declare src=""

    local -a newDirs=(
        "$HOME/archive"
        "$HOME/downloads/torrents"
        "$HOME/projects"
        "$HOME/server"
    )

    # Ask for the administrator password upfront
    sudo -v

    # Update existing `sudo` time stamp until this script has finished
    # (https://gist.github.com/3118588)
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    # --------------------------------------------------------------------------
    # | Directory Setup                                                        |
    # --------------------------------------------------------------------------

    print_info "Directory setup"

    # Rename the home directories to lowercase (just a personal preference)
    while read i; do

        src="$HOME/$i"
        dest="$HOME/$(printf "$i" |  tr "[:upper:]" "[:lower:]")"

        if [ "$src" != "$dest" ]; then
            execute_str "mv \"$src\" \"$dest\"" "$src → $dest"
        fi

    done < <(ls -l $HOME | grep '^d' | cut -d":" -f2 | cut -d' ' -f2-)

    tmp="$(cat "$HOME/.config/user-dirs.dirs")"
    printf "$tmp" | sed -e 's/\/\(.*\)/\/\L\1/g' >"$HOME/.config/user-dirs.dirs"

    # Create additional directories
    for i in ${newDirs[@]}; do
        mkd "$i"
    done

    # --------------------------------------------------------------------------
    # | Installation                                                           |
    # --------------------------------------------------------------------------

    print_info "Installation (this may take a while)"

    # Add software sources

    # Firefox Nightly
    [ $(cmd_exists "firefox-trunk") -eq 0 ] \
        && add_ppa "ubuntu-mozilla-daily/ppa"

    # Google Chrome
    [ $(cmd_exists "google-chrome") -eq 0 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/deb/ stable main" \
                "google-chrome.list"

    # Google Talk Plugin
    [ $(cmd_exists "/opt/google/talkplugin/GoogleTalkPlugin") -eq 0 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/talkplugin/deb/ stable main" \
                "google-talkplugin.list"

    # NodeJS
    [ $(cmd_exists "node") -eq 0 ] \
        && add_ppa "chris-lea/node.js"

    # Opera & Opera Next
    [ $(cmd_exists "opera") -eq 0 ] \
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

    install_pkg "apache2"
    install_pkg "chmsee"
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
    install_pkg "pidgin"
    install_pkg "vim-gnome" "vim"
    install_pkg "vlc"
    install_pkg "xchat"

    # --------------------------------------------------------------------------
    # | Settings                                                               |
    # --------------------------------------------------------------------------

    print_info "Settings"

    # Get all settings: `gsettings list-recursively`

    execute "set_appearance_settings" "Appearance"
    execute "set_ui_and_ux_settings" "UI & UX"

    # --------------------------------------------------------------------------
    # | Clean Up & Restart                                                     |
    # --------------------------------------------------------------------------

    print_info "Clean up"

    execute "update_and_upgrade" "update & upgrade"
    execute "remove_unneeded_pkgs" "autoremove"

    print_info "All done. Restarting ..."
    sleep 10
    sudo shutdown -r now

}

main
