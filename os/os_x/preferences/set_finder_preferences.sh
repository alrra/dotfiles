#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true \
                && defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true \
                && defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true" \
        "Automatically open a new Finder window when a volume is mounted"

    execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
        "Use full POSIX path as window title"

    execute "defaults write com.apple.finder DisableAllAnimations -bool true" \
        "Disable all animations"

    execute "defaults write com.apple.finder WarnOnEmptyTrash -bool false" \
        "Disable the warning before emptying the Trash"

    execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
        "Search the current directory by default"

    execute "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false" \
        "Disable warning when changing a file extension"

    execute "defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'" \
        "Use list view in all Finder windows by default"

    execute "defaults write com.apple.finder NewWindowTarget -string 'PfDe' \
                && defaults write com.apple.finder NewWindowTargetPath -string \"file://$HOME/Desktop/\"" \
        "Set 'Desktop' as the default location for new Finder windows"

    execute "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true \
                && defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true \
                && defaults write com.apple.finder ShowMountedServersOnDesktop -bool true \
                && defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true" \
        "Show icons for hard drives, servers, and removable media on the desktop"

    execute "defaults write com.apple.finder ShowRecentTags -bool false" \
        "Do not show recent tags"

    execute "defaults write NSGlobalDomain AppleShowAllExtensions -bool true" \
        "Show all filename extensions"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 72' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:iconSize 72' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 72' ~/Library/Preferences/com.apple.finder.plist" \
        "Set icon size"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 1' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 1' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 1' ~/Library/Preferences/com.apple.finder.plist" \
        "Set icon grid spacing size"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist" \
        "Set icon label text size"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist" \
        "Set icon label position"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist" \
        "Show item info"

    execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist \
                && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist" \
        "Set sort method"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Finder\n\n"
    set_preferences

    killall "Finder" &> /dev/null

}

main
