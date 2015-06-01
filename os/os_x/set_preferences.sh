#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# ----------------------------------------------------------------------
# | Chrome                                                             |
# ----------------------------------------------------------------------

set_chrome_preferences() {

    execute 'defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false' \
        'Disable backswipe'

    execute 'defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true' \
        'Expand print dialog by default'

    execute 'defaults write com.google.Chrome DisablePrintPreview -bool true' \
        'Use system-native print preview dialog'

}

# ----------------------------------------------------------------------
# | Chrome Canary                                                      |
# ----------------------------------------------------------------------

set_chrome_canary_preferences() {

    execute 'defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false' \
        'Disable backswipe'

    execute 'defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true' \
        'Expand print dialog by default'

    execute 'defaults write com.google.Chrome.canary DisablePrintPreview -bool true' \
        'Use system-native print preview dialog'

}

# ----------------------------------------------------------------------
# | Dashboard                                                          |
# ----------------------------------------------------------------------

set_dashboard_preferences() {

    execute 'defaults write com.apple.dashboard mcx-disabled -bool true' \
        'Disable Dashboard'

}

# ----------------------------------------------------------------------
# | Dock                                                               |
# ----------------------------------------------------------------------

set_dock_preferences() {

    execute 'defaults write com.apple.dock autohide -bool true' \
        'Automatically hide/show the Dock'

    execute 'defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true' \
        'Enable spring loading for all Dock items'

    execute 'defaults write com.apple.dock expose-animation-duration -float 0.2' \
        'Speed up Mission Control animations'

    execute 'defaults write com.apple.dock expose-group-by-app -bool false' \
        'Do not group windows by application in Mission Control'

    execute 'defaults write com.apple.dock mineffect -string "scale"' \
        'Change minimize/maximize window effect'

    execute 'defaults write com.apple.dock minimize-to-application -bool true' \
        'Reduce clutter by minimizing windows into their application icons'

    execute 'defaults write com.apple.dock mru-spaces -bool false' \
        'Do not automatically rearrange spaces based on most recent use'

    execute 'defaults write com.apple.dock persistent-apps -array' \
        'Wipe all app icons'

    execute 'defaults write com.apple.dock show-process-indicators -bool true' \
        'Show indicator lights for open applications'

    execute 'defaults write com.apple.dock showhidden -bool true' \
        'Make icons of hidden applications translucent'

    execute 'defaults write com.apple.dock tilesize -i' \
        'Set icon size'

}

# ----------------------------------------------------------------------
# | Finder                                                             |
# ----------------------------------------------------------------------

set_finder_preferences() {

    execute 'defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true &&
             defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true &&
             defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true' \
        "Automatically open a new Finder window when a volume is mounted"

    execute 'defaults write com.apple.finder _FXShowPosixPathInTitle -bool true' \
        'Use full POSIX path as window title'

    execute 'defaults write com.apple.finder DisableAllAnimations -bool true' \
        'Disable all animations'

    execute 'defaults write com.apple.finder WarnOnEmptyTrash -bool false' \
        'Disable the warning before emptying the Trash'

    # execute 'defaults write com.apple.finder EmptyTrashSecurely -bool true'
    #     'Enable "Secure Empty Trash"'
    # (Security of data on disk: https://www.youtube.com/watch?v=4SSSMi4X_mA)

    execute 'defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"' \
        'Search the current directory by default'

    execute 'defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false' \
        'Disable warning when changing a file extension'

    execute 'defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"' \
        'Use list view in all Finder windows by default'

    execute 'defaults write com.apple.finder NewWindowTarget -string "PfDe" &&
             defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"' \
        'Set "Desktop" as the default location for new Finder windows'

    execute 'defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true &&
             defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true &&
             defaults write com.apple.finder ShowMountedServersOnDesktop -bool true &&
             defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true' \
        'Show icons for hard drives, servers, and removable media on the desktop'

    execute "defaults write com.apple.finder ShowRecentTags -bool false" \
        "Don't show recent tags"

    execute "defaults write NSGlobalDomain AppleShowAllExtensions -bool true" \
        "Show all filename extensions"

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist' \
        'Set icon size'

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist' \
        'Set icon grid spacing size'

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist' \
        'Set icon label text size'

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist' \
        'Set icon label position'

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist' \
        'Show item info'

    execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist &&
             /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist' \
        'Set sort method'

}

# ----------------------------------------------------------------------
# | Keyboard                                                           |
# ----------------------------------------------------------------------

set_keyboard_preferences() {

    execute 'defaults write NSGlobalDomain AppleKeyboardUIMode -int 3' \
        'Enable full keyboard access for all controls'

    execute 'defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false' \
        'Disable press-and-hold in favor of key repeat'

    execute 'defaults write NSGlobalDomain "InitialKeyRepeat_Level_Saved" -int 15' \
        'Set delay until repeat'

    execute 'defaults write NSGlobalDomain KeyRepeat -int 2' \
        'Set the key repeat rate to fast'

    execute 'defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false' \
        'Disable smart quotes'

    execute 'defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false' \
        'Disable smart dashes'

}

# ----------------------------------------------------------------------
# | Language & Region                                                  |
# ----------------------------------------------------------------------

set_language_and_region_preferences() {

    execute 'defaults write NSGlobalDomain AppleLanguages -array "en" "ro"' \
        'Set language'

    execute 'defaults write NSGlobalDomain AppleLocale -string "en_RO@currency=EUR"' \
        'Set locale'

    execute 'defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"' \
        'Set measurement units'

    execute 'sudo systemsetup -settimezone "Europe/Bucharest"' \
        'Set timezone'

    execute 'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false' \
        'Disable auto-correct'

}

# ----------------------------------------------------------------------
# | Maps                                                               |
# ----------------------------------------------------------------------

set_maps_preferences() {

    execute 'defaults write com.apple.Maps LastClosedWindowViewOptions "{
                localizeLabels = 1;   // show labels in English
                mapType = 11;         // show hybrid map
                trafficEnabled = 0;   // do not show traffic
             }"' \
        'Set view options'

}

# ----------------------------------------------------------------------
# | Safari                                                             |
# ----------------------------------------------------------------------

set_safari_preferences() {

    execute 'defaults write com.apple.Safari AutoOpenSafeDownloads -bool false' \
        'Disable opening "safe" files automatically'

    execute 'defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true' \
        'Set backspace key to go to the previous page in history'


    execute 'defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true &&
             defaults write com.apple.Safari IncludeDevelopMenu -bool true &&
             defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true' \
        'Enable the "Develop" menu and the "Web Inspector"'

    execute 'defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false' \
        'Set search type to "Contains" instead of "Starts With"'

    execute 'defaults write com.apple.Safari HomePage -string "about:blank"' \
        'Set home page to "about:blank"'

    execute 'defaults write com.apple.Safari IncludeInternalDebugMenu -bool true' \
        'Enable "Debug" menu'

    execute 'defaults write com.apple.Safari ShowFavoritesBar -bool false' \
        'Hide bookmarks bar by default'

    execute 'defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true' \
        'Show the full URL in the address bar'

    execute 'defaults write com.apple.Safari SuppressSearchSuggestions -bool true &&
             defaults write com.apple.Safari UniversalSearchEnabled -bool false' \
        'Don’t send search queries to Apple'

    execute 'defaults write NSGlobalDomain WebKitDeveloperExtras -bool true' \
        'Add a context menu item for showing the "Web Inspector" in web views'

}

# ----------------------------------------------------------------------
# | Terminal                                                           |
# ----------------------------------------------------------------------

set_terminal_preferences() {

    execute "defaults write com.apple.terminal FocusFollowsMouse -string true" \
        "Make the focus automatically follow the mouse"

    execute "defaults write com.apple.terminal StringEncodings -array 4" \
        "Only use UTF-8"

    osascript <<EOD

    tell application "Terminal"

        local allOpenedWindows
        local initialOpenedWindows
        local windowID
        set themeName to "Solarized Dark"

        (* Store the IDs of all the open terminal windows *)
        set initialOpenedWindows to id of every window

        (* Open the custom theme so that it gets added to the list
           of available terminal themes (note: this will open two
           additional terminal windows) *)
        do shell script "open '" & themeName & ".terminal'"

        (* Wait a little bit to ensure that the custom theme is added *)
        delay 1

        (* Set the custom theme as the default terminal theme *)
        set default settings to settings set themeName

        (* Get the IDs of all the currently opened terminal windows *)
        set allOpenedWindows to id of every window

        repeat with windowID in allOpenedWindows

            (* Close the additional windows that were opened in order
               to add the custom theme to the list of terminal themes *)
            if initialOpenedWindows does not contain windowID then
                close (every window whose id is windowID)

            (* Change the theme for the initial opened terminal windows
               to remove the need to close them in order for the custom
               theme to be applied *)
            else
                set current settings of tabs of (every window whose id is windowID) to settings set themeName
            end if

        end repeat

    end tell

EOD
    print_result $? "Set custom terminal theme"

}

# ----------------------------------------------------------------------
# | TextEdit                                                           |
# ----------------------------------------------------------------------

set_textedit_preferences() {

    execute 'defaults write com.apple.TextEdit PlainTextEncoding -int 4 &&
             defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4' \
        'Open and save files as UTF-8 encoded'

    execute 'defaults write com.apple.TextEdit RichText -' \
        'Use plain text mode for new documents'

}

# ----------------------------------------------------------------------
# | Trackpad                                                           |
# ----------------------------------------------------------------------

set_trackpad_preferences() {

    execute 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true &&
             defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 &&
             defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1' \
        'Enable "Tap to click"'

    execute 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true &&
             defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true &&
             defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 &&
             defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0' \
        'Map "click or tap with two fingers" to the secondary click'

}

# ----------------------------------------------------------------------
# | Transmission.app                                                   |
# ----------------------------------------------------------------------

set_transmission_preferences() {

    execute 'defaults write org.m0k.transmission DeleteOriginalTorrent -bool true' \
        'Delete the original torrent files'

    execute 'defaults write org.m0k.transmission DownloadAsk -bool false' \
        'Don’t prompt for confirmation before downloading'

    execute 'defaults write org.m0k.transmission DownloadChoice -string "Constant" &&
             defaults write org.m0k.transmission DownloadFolder -string "$HOME/Downloads"' \
        'Use "~/Downloads" to store complete downloads'

    execute 'defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true &&
             defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/torrents"' \
        'Use "~/Downloads/torrents" to store incomplete downloads'

    execute 'defaults write org.m0k.transmission WarningDonate -bool false' \
        'Hide the donate message'

    execute 'defaults write org.m0k.transmission WarningLegal -bool false' \
        'Hide the legal disclaimer'

}

# ----------------------------------------------------------------------
# | UI/UX                                                              |
# ----------------------------------------------------------------------

set_ui_and_ux_preferences() {

    execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true" \
        "Avoid creating '.DS_Store' files on network volumes"

    execute 'defaults write com.apple.menuextra.battery ShowPercent -string "NO"' \
        'Hide battery percentage from the menu bar'

    execute 'defaults write com.apple.LaunchServices LSQuarantine -bool false' \
        'Disable "Are you sure you want to open this application?" dialog'

    # execute 'defaults write com.apple.loginwindow TALLogoutSavesState 0' \
    #     'Disable "Reopen windows when logging back in"'

    execute 'defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true' \
        'Automatically quit the printer app once the print jobs are completed'

    execute 'defaults write com.apple.screencapture disable-shadow -bool true' \
        'Disable shadow in screenshots'

    execute 'defaults write com.apple.screencapture location -string "$HOME/Desktop"' \
        'Save screenshots to the Desktop'

    execute 'defaults write com.apple.screencapture type -string "png"' \
        'Save screenshots as PNGs'

    execute 'defaults write com.apple.screensaver askForPassword -int 1 &&
             defaults write com.apple.screensaver askForPasswordDelay -int 0'\
        'Require password immediately after into sleep or screen saver mode'

    execute 'defaults write NSGlobalDomain AppleFontSmoothing -int 2' \
        'Enable subpixel font rendering on non-Apple LCDs'

    execute 'defaults write NSGlobalDomain AppleShowScrollBars -string "Always"' \
        'Always show scrollbars'

    execute 'defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true' \
        'Disable automatic termination of inactive apps'

    execute 'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true' \
        'Expand save panel by default'

    execute 'defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2' \
        'Set sidebar icon size to medium'

    execute 'defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false' \
        'Disable resume system-wide'

    execute 'defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true' \
        'Expand print panel by default'

    execute 'sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Laptop" &&
             sudo scutil --set ComputerName "Laptop" &&
             sudo scutil --set HostName "Laptop" &&
             sudo scutil --set LocalHostName "Laptop"' \
        'Set computer name'

    execute "sudo systemsetup -setrestartfreeze on" \
        "Restart automatically if the computer freezes"

    execute 'sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0 &&
             sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist &&
             sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist' \
        'Turn Bluetooth off'

    execute '   for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
                    sudo defaults write "${domain}" dontAutoLoad -array \
                        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
                        "/System/Library/CoreServices/Menu Extras/Volume.menu"
                done && \

                sudo defaults write com.apple.systemuiserver menuExtras -array \
                    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
                    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
                    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
                    "/System/Library/CoreServices/Menu Extras/Clock.menu"
            ' \
        'Hide Time Machine and Volume icons from the menu bar'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -a PROCESSES_TO_TERMINATE=(
        "Dock"
        "Finder"
        "Google Chrome Canary"
        "Google Chrome"
        "Maps"
        "Safari"
        "SystemUIServer"
        "TextEdit"
        "Transmission"
        "cfprefsd"
    )

    print_in_purple "  Chrome\n\n"
    set_chrome_preferences

    print_in_purple "\n  Chrome Canary\n\n"
    set_chrome_canary_preferences

    print_in_purple "\n  Dashboard\n\n"
    set_dashboard_preferences

    print_in_purple "\n  Dock\n\n"
    set_dock_preferences

    print_in_purple "\n  Finder\n\n"
    set_finder_preferences

    print_in_purple "\n  Keyboard\n\n"
    set_keyboard_preferences

    print_in_purple "\n  Language & Region\n\n"
    set_language_and_region_preferences

    print_in_purple "\n  Maps\n\n"
    set_maps_preferences

    print_in_purple "\n  Safari\n\n"
    set_safari_preferences

    print_in_purple "\n  Terminal\n\n"
    set_terminal_preferences

    print_in_purple "\n  TextEdit\n\n"
    set_textedit_preferences

    print_in_purple "\n  Trackpad\n\n"
    set_trackpad_preferences

    print_in_purple "\n  Transmission\n\n"
    set_transmission_preferences

    print_in_purple "\n  UI & UX\n\n"
    set_ui_and_ux_preferences

    for i in ${!PROCESSES_TO_TERMINATE[*]}; do
	    killall "$i" &> /dev/null
    done

}

main
