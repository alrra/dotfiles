#!/bin/bash

SCRIPT_PATH="${BASH_SOURCE%/*}"   # http://mywiki.wooledge.org/BashFAQ/028

# ##############################################################################
# # HELPER FUNCTIONS                                                           #
# ##############################################################################

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 1 \
        || printf 0
}

execute_str() {
    sudo sh -c "$1" &> /dev/null
    print_result $? "$2"
}

execute() {
    $1 &> /dev/null
    print_result $? "$2"
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 [a file with the same name already exists]"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    printf "\e[0;31m  ✖ $1 $2\e[0m\n"
}

print_info() {
    printf "\n\e[0;33m $1\e[0m\n\n"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"
}

print_success() {
    printf "\e[0;32m  ✔ $1\e[0m\n"
}

# ##############################################################################
# # PREFERENCES FUNCTIONS                                                      #
# ##############################################################################

# ------------------------------------------------------------------------------
# | App Store                                                                  |
# ------------------------------------------------------------------------------

set_app_store_preferences() {

    # Enable WebKit Developer Tools
    defaults write com.apple.appstore WebKitDeveloperExtras -bool true

}

# ------------------------------------------------------------------------------
# | Dashboard                                                                  |
# ------------------------------------------------------------------------------

set_dashboard_preferences() {

    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

}

# ------------------------------------------------------------------------------
# | Desktop & Screen Saver                                                     |
# ------------------------------------------------------------------------------

set_desktop_preferences() {

    # Enable HiDPI display modes
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Don't automatically rearrange spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Require password immediately after the
    # computer went into sleep or screen saver mode
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Save screenshots to the ~/Desktop
    defaults write com.apple.screencapture location -string "$HOME/Desktop"

    # Save screenshots as PNG
    # (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

}

# ------------------------------------------------------------------------------
# | Dock                                                                       |
# ------------------------------------------------------------------------------

set_dock_preferences() {

    # Enable automatically hide and show
    defaults write com.apple.dock autohide -bool true

    # Enable highlight hover effect for the grid view of a stack
    defaults write com.apple.dock mouse-over-hilte-stack -bool true

    # Enable spring loading
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # Make Dock more transparent (OS X 10.9)
    defaults write com.apple.dock hide-mirror -bool true

    # Set the icon size
    defaults write com.apple.dock tilesize -int 36

    # Show indicator lights for open applications
    defaults write com.apple.dock show-process-indicators -bool true

    # Make icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Wipe all app icons from the Dock
    defaults write com.apple.dock persistent-apps -array

    # Reduce Dock clutter by minimizing windows into their app icons
    defaults write com.apple.dock minimize-to-application -bool true

}

# ------------------------------------------------------------------------------
# | Finder                                                                     |
# ------------------------------------------------------------------------------

set_finder_preferences() {

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Disable all animations
    defaults write com.apple.finder DisableAllAnimations -bool true

    # Disable disk image verification
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Enable snap-to-grid for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    # Search the current directory by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Set grid spacing for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

    # Set the size of icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 70" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 70" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 70" ~/Library/Preferences/com.apple.finder.plist

    # Show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Show item info below icons on the desktop and in other icon views
    #/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

    # Use full POSIX path as window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Use list view in all Finder windows by default
    # (other view modes: `icnv`, `clmv`, `Flwv`)
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Use `Secure Empty Trash` by default
    # (see: Security of Data on Disk: http://www.youtube.com/watch?v=4SSSMi4X_mA)
    #defaults write com.apple.finder EmptyTrashSecurely -bool true

    # Set Desktop as the default location for new Finder windows
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

}

# ------------------------------------------------------------------------------
# | Keyboard                                                                   |
# ------------------------------------------------------------------------------

set_keyboard_preferences() {

    # Automatically illuminate the built-in keyboard in low light
    defaults write com.apple.BezelServices kDim -bool true

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Set the key repeat rate to fast
    defaults write NSGlobalDomain KeyRepeat -int 0

    # Turn off the built-in keyboard's illumination
    # when computer is not used for 5 minutes
    defaults write com.apple.BezelServices kDimTime -int 300

}

# ------------------------------------------------------------------------------
# | Language & Text                                                            |
# ------------------------------------------------------------------------------

set_language_and_text_preferences() {

    # Disable auto-correct
    #defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Set language and text formats
    defaults write NSGlobalDomain AppleLanguages -array "en"
    defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true

}

# ------------------------------------------------------------------------------
# | Mail                                                                       |
# ------------------------------------------------------------------------------

set_mail_preferences() {

    # Disable send and reply animations
    defaults write com.apple.mail DisableReplyAnimations -bool true
    defaults write com.apple.mail DisableSendAnimations -bool true

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

    # Add a context menu item for showing the Web Inspector in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Allow hitting the backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Disable thumbnail cache for History and Top Sites
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

    # Disable opening `safe` files automatically
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    # Enable debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Enable the Develop menu and the Web Inspector
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

    # Hide bookmarks bar by default
    defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Remove icons from bookmarks bar
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"

    # Set home page to `about:blank`
    defaults write com.apple.Safari HomePage -string "about:blank"

    # Set search type to `Contains` instead of `Starts With`
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

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
    open "$SCRIPT_PATH/Solarized Dark.terminal"
    defaults write com.apple.Terminal "Default Window Settings" -string "Solarized Dark"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Solarized Dark"
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
# | Time Machine                                                               |
# ------------------------------------------------------------------------------

set_time_machine_preferences() {

    # Prevent prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Disable local backups
    hash tmutil &> /dev/null && sudo tmutil disablelocal

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
# | Transmission                                                               |
# ------------------------------------------------------------------------------

set_transmission_preferences() {

    # Delete the original torrent files
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    # Don’t prompt for confirmation before downloading
    defaults write org.m0k.transmission DownloadAsk -bool false

    # Hide the donate message
    defaults write org.m0k.transmission WarningDonate -bool false

    # Hide the legal disclaimer
    defaults write org.m0k.transmission WarningLegal -bool false

    # Use `~/downloads/torrents` to store incomplete downloads
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/downloads/torrents"

}

# ------------------------------------------------------------------------------
# | UI/UX                                                                      |
# ------------------------------------------------------------------------------

set_ui_and_ux_preferences() {

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Always show scrollbars
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Disable automatic termination of inactive apps
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

    # Disable menu bar transparency
    defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

    # Disable opening and closing window animations
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

    # Disable resume system-wide
    defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

    # Disable the “Are you sure you want to open this application?” dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Disable the crash reporter
    defaults write com.apple.CrashReporter DialogType -string "none"

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

    # Hide the battery percentage from the menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "NO"

    # Hide the Bluetooth, Time Machine and Volume icons from the menu bar
    defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Battery.menu" \
        "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
        "/System/Library/CoreServices/Menu Extras/Clock.menu"

    # Never go into computer sleep mode
    #systemsetup -setcomputersleep Off > /dev/null

    # Restart automatically if the computer freezes
    systemsetup -setrestartfreeze on

    # Save to disk by default (and not to iCloud)
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    # Set computer name
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Laptop"
    sudo scutil --set HostName "Laptop"
    sudo scutil --set ComputerName "Laptop"
    sudo scutil --set LocalHostName "Laptop"

    # Set Help Viewer windows to non-floating mode
    defaults write com.apple.helpviewer DevMode -bool true

}

# ##############################################################################
# # MAIN                                                                       #
# ##############################################################################

main() {

    # Ensure the OS is Mac OS X
    if [ "$(uname -s)" != "Darwin" ]; then
        print_error "Sorry, this script is for Mac OS X only."
        exit
    else
        # Ensure that the Mac OS version is 10.9.0+
        if [ "10.9" = "$(printf '%s\n%s' '10.9' '$(sw_vers -productVersion)' | sort | head -n1)" ]; then
            print_error "Sorry, this script is intended only for Mac OS X v10.9.0+."
            exit
        fi
    fi

    # --------------------------------------------------------------------------
    # | Init                                                                   |
    # --------------------------------------------------------------------------

    declare i=""
    declare dest=""
    declare tmp=""
    declare src=""

    # Homebrew Formulae
    # https://github.com/Homebrew/homebrew
    local -a homebrewFormulae=(
        "git"
        "imagemagick --with-webp"
        "node"
        "phinze/cask/brew-cask"
        "vim --override-system-vi"
        "zopfli"
    )

    # Homebrew Casks
    # https://github.com/phinze/homebrew-cask
    local -a homebrewCasks=(
        "android-file-transfer"
        "chromium"
        "dropbox"
        "flash"
        "google-chrome"
        "imagealpha"
        "imageoptim"
        "macvim"
        "opera"
        "opera-next"
        "the-unarchiver"
        "transmission"
        "virtualbox"
        "vlc"
    )

    # Homebrew Alternate Casks
    # https://github.com/caskroom/homebrew-versions
    local -a homebrewAlternateCasks=(
        "google-chrome-canary"
        "firefox-nightly"
        "opera-developer"
        "webkit-nightly"
    )

    local -a newDirs=(
        "$HOME/archive"
        "$HOME/Downloads/torrents"
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

    # Create additional directories
    for i in ${newDirs[@]}; do
        mkd "$i"
    done

    # --------------------------------------------------------------------------
    # | Installation                                                           |
    # --------------------------------------------------------------------------

    print_info "Installation (this may take a while!)"

    # XCode Command Line Tools
    if [ $(xcode-select -p &> /dev/null; echo $?) -ne 0 ]; then
        xcode-select --install &> /dev/null

        # Wait until the XCode Command Line Tools are installed
        while [ $(xcode-select -p &> /dev/null; echo $?) -ne 0 ]; do
            sleep 5
        done
    fi

    print_success "XCode Command Line Tools"
    printf "\n"

    # Homebrew
    if [ $(cmd_exists "brew") -eq 0 ]; then
        printf '\n' | ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        #  └─ simulate ENTER keypress
        print_result $? "brew"
    else
        print_success "brew"
        execute "brew update" "brew [update]"
        execute "brew upgrade" "brew [upgrade]"
        execute "brew cleanup" "brew [cleanup]"
        printf "\n"
    fi

    if [ $(cmd_exists "brew") -eq 1 ]; then

        # Homebrew formulae
        for i in ${!homebrewFormulae[*]}; do
            tmp="${homebrewFormulae[$i]}"
            [ $(brew list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                && print_success "$tmp" \
                || execute "brew install $tmp" "$tmp"
        done

        printf "\n"

        # Homebrew casks
        if [ $(brew list brew-cask &> /dev/null; printf $?) -eq 0 ]; then

            for i in ${!homebrewCasks[*]}; do
                tmp="${homebrewCasks[$i]}"
                [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                    && print_success "$tmp" \
                    || execute "brew cask install $tmp" "$tmp"
            done

            printf "\n"

            # Homebrew alternate casks
            brew tap caskroom/versions &> /dev/null

            if [ $(brew tap | grep "caskroom/versions" &> /dev/null; printf $?) -eq 0 ]; then
                for i in ${!homebrewAlternateCasks[*]}; do
                    tmp="${homebrewAlternateCasks[$i]}"
                    [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
                        && print_success "$tmp" \
                        || execute "brew cask install $tmp" "$tmp"
                done
            fi
        fi

    fi

    # --------------------------------------------------------------------------
    # | Preferences                                                            |
    # --------------------------------------------------------------------------

    print_info "Preferences"

    execute "set_app_store_preferences" "App Store"
    execute "set_dashboard_preferences" "Dashboard"
    execute "set_desktop_preferences" "Desktop"
    execute "set_dock_preferences" "Dock"
    execute "set_finder_preferences" "Finder"
    execute "set_keyboard_preferences" "Keyboard"
    execute "set_language_and_text_preferences" "Language & Text"
    execute "set_mail_preferences" "Mail"
    execute "set_maps_preferences" "Maps"
    execute "set_safari_preferences" "Safari"
    execute "set_terminal_preferences" "Terminal"
    execute "set_textedit_preferences" "TextEdit"
    execute "set_time_machine_preferences" "Time Machine"
    execute "set_trackpad_preferences" "Trackpad"
    execute "set_transmission_preferences" "Transmission"
    execute "set_ui_and_ux_preferences" "UI & UX"

    # --------------------------------------------------------------------------
    # | Clean Up & Restart                                                     |
    # --------------------------------------------------------------------------

    print_info "Clean up"

    if [ $(cmd_exists "brew") -eq 1 ]; then
        execute "brew cleanup" "brew [cleanup]"
    fi

    for i in "App Store" "Dock" "Finder" "Mail" "Safari" \
	         "SystemUIServer" "TextEdit" "Transmission"; do
	    killall "$i" &> /dev/null
    done

    print_info "All done. Restarting ..."
    sleep 10
    sudo shutdown -r now

}

main
