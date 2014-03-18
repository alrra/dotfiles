#!/bin/bash

# ------------------------------------------------------------------------------
# | Dashboard                                                                  |
# ------------------------------------------------------------------------------

set_dashboard_preferences() {

    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

}

# ------------------------------------------------------------------------------
# | Dock                                                                       |
# ------------------------------------------------------------------------------

set_dock_preferences() {

    # Automatically hide or show the Dock
    defaults write com.apple.dock autohide -bool true

    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # Speed up Mission Control animations
    defaults write com.apple.dock expose-animation-duration -float 0.2

    # Don’t group windows by application in Mission Control
    defaults write com.apple.dock expose-group-by-app -bool false

    # Make Dock more transparent
    defaults write com.apple.dock hide-mirror -bool true

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"

    # Reduce Dock clutter by minimizing windows into their application icons
    defaults write com.apple.dock minimize-to-application -bool true

    # Don't automatically rearrange spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Wipe all app icons from the Dock
    defaults write com.apple.dock persistent-apps -array ""

    # Show indicator lights for open applications
    defaults write com.apple.dock show-process-indicators -bool true

    # Make icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Set the icon size
    defaults write com.apple.dock tilesize -int 55

}

# ------------------------------------------------------------------------------
# | Finder                                                                     |
# ------------------------------------------------------------------------------

set_finder_preferences() {

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Use full POSIX path as window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Disable all animations
    defaults write com.apple.finder DisableAllAnimations -bool true

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Enable `Secure Empty Trash`
    # (Security of data on disk: http://www.youtube.com/watch?v=4SSSMi4X_mA)
    #defaults write com.apple.finder EmptyTrashSecurely -bool true

    # Search the current directory by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Use list view in all Finder windows by default
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Set `Desktop` as the default location for new Finder windows
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Don't show recent tags
    defaults write com.apple.finder ShowRecentTags -bool false

    # Show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # For icons on the desktop and in other icon views:

        # Set size
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist

        # Set grid spacing size
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist

        # Set label text size
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist

        # Set label position
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

        # Show item info
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

        # Set sort method
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist

}

# ------------------------------------------------------------------------------
# | Keyboard                                                                   |
# ------------------------------------------------------------------------------

set_keyboard_preferences() {

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Delay Until Repeat
    defaults write NSGlobalDomain "InitialKeyRepeat_Level_Saved" -int 15

    # Set the key repeat rate to fast
    defaults write NSGlobalDomain KeyRepeat -int 2

    # Disable smart quotes
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Disable smart dashes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

}

# ------------------------------------------------------------------------------
# | Language & Region                                                          |
# ------------------------------------------------------------------------------

set_language_and_region_preferences() {

    # Set language and text formats
    defaults write NSGlobalDomain AppleLanguages -array "en" "ro"
    defaults write NSGlobalDomain AppleLocale -string "en_RO@currency=EUR"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true

    # Disable auto-correct
    #defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    #defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

    # Set the timezone
    # (see `systemsetup -listtimezones` for other values)
    systemsetup -settimezone "Europe/Bucharest" &> /dev/null

}

# ------------------------------------------------------------------------------
# | Maps                                                                       |
# ------------------------------------------------------------------------------

set_maps_preferences() {

    # Set view options
    defaults write com.apple.Maps LastClosedWindowViewOptions "{
        localizeLabels = 1;   // show labels in English
        mapType = 11;         // show hybrid map
        trafficEnabled = 0;   // do not show traffic
    }"

}

# ------------------------------------------------------------------------------
# | Safari                                                                     |
# ------------------------------------------------------------------------------

set_safari_preferences() {

    # Disable opening `safe` files automatically
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    # Allow hitting the backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Enable the `Develop` menu and the `Web Inspector`
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

    # Set search type to `Contains` instead of `Starts With`
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Set home page to `about:blank`
    defaults write com.apple.Safari HomePage -string "about:blank"

    # Enable `Debug` menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Hide bookmarks bar by default
    defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Add a context menu item for showing the `Web Inspector` in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

}

# ------------------------------------------------------------------------------
# | Terminal                                                                   |
# ------------------------------------------------------------------------------

set_terminal_preferences() {

    # Make the focus automatically follow the mouse
    defaults write com.apple.terminal FocusFollowsMouse -string true

    # Only use UTF-8
    defaults write com.apple.terminal StringEncodings -array 4

    # Use a custom theme
    open "$SCRIPT_PATH/solarized_dark.terminal"
    defaults write com.apple.Terminal "Default Window Settings" -string "solarized_dark"
    defaults write com.apple.Terminal "Startup Window Settings" -string "solarized_dark"
    defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"

}

# ------------------------------------------------------------------------------
# | TextEdit                                                                   |
# ------------------------------------------------------------------------------

set_textedit_preferences() {

    # Open and save files as UTF-8 encoded
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Use plain text mode for new documents
    defaults write com.apple.TextEdit RichText -int 0

}

# ------------------------------------------------------------------------------
# | Trackpad                                                                   |
# ------------------------------------------------------------------------------

set_trackpad_preferences() {

    # Enable `Tap to click`
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Map `click or tap with two fingers` to the secondary click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0

}

# ------------------------------------------------------------------------------
# | Transmission.app                                                           |
# ------------------------------------------------------------------------------

set_transmission_preferences() {

    # Delete the original torrent files
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    # Don’t prompt for confirmation before downloading
    defaults write org.m0k.transmission DownloadAsk -bool false

    # Use `~/Downloads` to store complete downloads
    defaults write org.m0k.transmission DownloadChoice -string "Constant"
    defaults write org.m0k.transmission DownloadFolder -string "$HOME/Downloads";

    # Use `~/Downloads/torrents` to store incomplete downloads
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/torrents"

    # Hide the donate message
    defaults write org.m0k.transmission WarningDonate -bool false

    # Hide the legal disclaimer
    defaults write org.m0k.transmission WarningLegal -bool false

}

# ------------------------------------------------------------------------------
# | UI/UX                                                                      |
# ------------------------------------------------------------------------------

set_ui_and_ux_preferences() {

    # Avoid creating `.DS_Store` files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Hide the battery percentage from the menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "NO"

    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Disable `Reopen windows when logging back in`
    #defaults write com.apple.loginwindow TALLogoutSavesState 0

    # Automatically quit the printer app once the print jobs are completed
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Save screenshots to the ~/Desktop
    defaults write com.apple.screencapture location -string "$HOME/Desktop"

    # Save screenshots as PNGs
    defaults write com.apple.screencapture type -string "png"

    # Require password immediately after the computer went into
    # sleep or screen saver mode
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Disable menu bar transparency
    defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    # Always show scrollbars
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

    # Disable automatic termination of inactive apps
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

    # Set sidebar icon size to medium
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

    # Disable resume system-wide
    defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

    # Set computer name
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Laptop"
    sudo scutil --set ComputerName "Laptop"
    sudo scutil --set HostName "Laptop"
    sudo scutil --set LocalHostName "Laptop"

    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on

    # Turn Bluetooth off
    sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0
    sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
    sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist

    # Hide the Time Machine and Volume icons from the menu bar
    for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
        sudo defaults write "${domain}" dontAutoLoad -array \
            "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
            "/System/Library/CoreServices/Menu Extras/Volume.menu"
    done

    sudo defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Battery.menu" \
        "/System/Library/CoreServices/Menu Extras/Clock.menu"

}

# ------------------------------------------------------------------------------

set_preferences() {

    execute "set_dashboard_preferences" "Dashboard"
    execute "set_dock_preferences" "Dock"
    execute "set_finder_preferences" "Finder"
    execute "set_keyboard_preferences" "Keyboard"
    execute "set_language_and_region_preferences" "Language & Region"
    execute "set_maps_preferences" "Maps"
    execute "set_safari_preferences" "Safari"
    execute "set_terminal_preferences" "Terminal"
    execute "set_textedit_preferences" "TextEdit"
    execute "set_trackpad_preferences" "Trackpad"
    execute "set_transmission_preferences" "Transmission"
    execute "set_ui_and_ux_preferences" "UI & UX"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    if [ $(cmd_exists "brew") -eq 1 ]; then
        execute "brew cleanup" "brew [cleanup]"
    fi

    for i in "cfprefsd" "Dock" "Finder" "Safari" \
             "SystemUIServer" "TextEdit" "Transmission"; do
	    killall "$i" &> /dev/null
    done

}
