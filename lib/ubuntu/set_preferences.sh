#!/bin/bash

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

set_preferences() {

    log_info "Settings"

    # Get all settings: `gsettings list-recursively`

    execute "set_appearance_settings" "Appearance"
    execute "set_ui_and_ux_settings" "UI & UX"

}
