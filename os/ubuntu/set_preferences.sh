#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# ----------------------------------------------------------------------
# | Privacy                                                            |
# ----------------------------------------------------------------------

set_privacy_settings() {

    execute 'gsettings set com.canonical.Unity.Lenses remote-content-search "none"' \
        'Turn off "Remote Search" so that search terms in Dash do not get sent over the internet'

    execute 'gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false' \
        'Disable Dash "More suggestions" section'

}

# ----------------------------------------------------------------------
# | Terminal                                                           |
# ----------------------------------------------------------------------

set_terminal_settings() {

    execute 'gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 12"' \
        'Change font size'

    execute '
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false \
            && gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false \
            && gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3" \
            && gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636" \
            && gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"' \
        'Set custom terminal theme'

}

# ----------------------------------------------------------------------
# | UI/UX                                                              |
# ----------------------------------------------------------------------

set_ui_and_ux_settings() {

    execute 'gsettings set com.canonical.indicator.bluetooth visible false' \
        'Hide bluetooth icon from the menu bar'

    execute 'gsettings set com.canonical.indicator.sound visible false' \
        'Hide volume icon from the menu bar'

    execute 'gsettings set com.canonical.indicator.power icon-policy "charge" &&
             gsettings set com.canonical.indicator.power show-time false' \
        'Hide battery icon from the menu bar when the battery is not in use'

    execute 'gsettings set com.canonical.indicator.datetime custom-time-format "%l:%M %p" &&
             gsettings set com.canonical.indicator.datetime time-format "custom"' \
        'Use custom date format in the menu bar'

    execute 'gsettings set org.gnome.desktop.background picture-options "stretched"' \
        'Set desktop background image options'

    # execute 'gsettings set org.gnome.desktop.background picture-uri 'file:///home/...' &> /dev/null' \
    #     'Set desktop background image location'

    execute "gsettings set org.gnome.libgnomekbd.keyboard layouts \"[ 'us', 'ro' ]\"" \
        'Set keyboard languages'

    execute "gsettings set com.canonical.Unity.Launcher favorites \"[
        'ubiquity-gtkui.desktop',
        'nautilus-home.desktop',
        'chromium-browser.desktop',
        'google-chrome.desktop',
        'firefox.desktop',
        'firefox-trunk.desktop',
        'opera-browser.desktop',
        'opera-next-browser.desktop'
    ]\"" \
        'Set Launcher favorites'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "  Privacy\n\n"
    set_privacy_settings

    print_in_purple "\n  Terminal\n\n"
    set_terminal_settings

    print_in_purple "\n  UI & UX\n\n"
    set_ui_and_ux_settings

}

main
