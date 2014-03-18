#!/bin/bash

# ------------------------------------------------------------------------------
# | Privacy                                                                    |
# ------------------------------------------------------------------------------

set_privacy_settings() {

    local os_version="$(/usr/bin/lsb_release -rs)"

    # The privacy "issues" are present only in Ubuntu 12.10+
    # https://fixubuntu.com/
    if [ "$(compare_versions "$os_version" "12.04")" = ">" ]; then

        # Turn off "Remote Search", so that the search terms
        # introduced in `Dash` don't get sent over to third parties
        gsettings set "com.canonical.Unity.lenses" remote-content-search none

        # If the Ubuntu version is < 13.10, uninstall `unity-lens-shopping`
        if [ "$(compare_versions "$os_version" "13.10")" = "<" ]; then
            sudo apt-get remove -y unity-lens-shopping

        # If a later version is used, disable remote scopes
        else
            gsettings set "com.canonical.Unity.lenses" disabled-scopes \
                "[
                    'more_suggestions-amazon.scope',
                    'more_suggestions-ebay.scope',
                    'more_suggestions-populartracks.scope',
                    'music-musicstore.scope',
                    'more_suggestions-skimlinks.scope',
                    'more_suggestions-u1ms.scope',
                    'more_suggestions-ubuntushop.scope'
                ]"
        fi

        # Block connections to Ubuntu's ad server
        if ! grep -q "127.0.0.1 productsearch.ubuntu.com" /etc/hosts; then
             printf "\n127.0.0.1 productsearch.ubuntu.com" | sudo tee -a /etc/hosts >/dev/null
        fi
    fi

}

# ------------------------------------------------------------------------------
# | UI/UX                                                                      |
# ------------------------------------------------------------------------------

set_ui_and_ux_settings() {

    # Hide the bluetooth and volume icons from the menu bar
    gsettings set com.canonical.indicator.bluetooth visible false
    gsettings set com.canonical.indicator.sound visible false

    # Hide the battery icon from the menu bar when the battery is not in use
    gsettings set com.canonical.indicator.power icon-policy "charge"
    gsettings set com.canonical.indicator.power show-time false

    # Use custom date format in the menu bar
    # (for other date interpreted sequences: date --help)
    gsettings set com.canonical.indicator.datetime custom-time-format "%l:%M %p"
    gsettings set com.canonical.indicator.datetime time-format "custom"

    # Set desktop background image location and options
    gsettings set org.gnome.desktop.background picture-options "stretched"
    #gsettings set org.gnome.desktop.background picture-uri "file:///home/..."

    # Set keyboard languages
    gsettings set org.gnome.libgnomekbd.keyboard layouts "[ 'us', 'ro' ]"

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

set_preferences() {
    execute "set_privacy_settings" "Privacy"
    execute "set_ui_and_ux_settings" "UI & UX"
}
