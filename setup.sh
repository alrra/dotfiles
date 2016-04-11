#!/bin/bash

declare -r GITHUB_REPOSITORY="alrra/dotfiles"

declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/os/utils.sh"

declare dotfilesDirectory="$HOME/projects/dotfiles"

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1

}

download_dotfiles() {

    local tmpFile="$(mktemp /tmp/XXXXX)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    download "$DOTFILES_TARBALL_URL" "$tmpFile"
    print_result $? "Download archive" "true"
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_confirmation "Do you want to store the dotfiles in '$dotfilesDirectory'?"

    if ! answer_is_yes; then
        dotfilesDirectory=""
        while [ -z "$dotfilesDirectory" ]; do
            ask "Please specify another location for the dotfiles (path): "
            dotfilesDirectory="$(get_answer)"
        done
    fi

    # Ensure the `dotfiles` directory is available

    while [ -e "$dotfilesDirectory" ]; do
        ask_for_confirmation "'$dotfilesDirectory' already exists, do you want to overwrite it?"
        if answer_is_yes; then
            rm -rf "$dotfilesDirectory"
            break
        else
            dotfilesDirectory=""
            while [ -z "$dotfilesDirectory" ]; do
                ask "Please specify another location for the dotfiles (path): "
                dotfilesDirectory="$(get_answer)"
            done
        fi
    done

    printf "\n"

    mkdir -p "$dotfilesDirectory"
    print_result $? "Create '$dotfilesDirectory'" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Extract archive in the `dotfiles` directory

    extract "$tmpFile" "$dotfilesDirectory"
    print_result $? "Extract archive" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Remove archive

    rm -rf "$tmpFile"
    print_result $? "Remove archive"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    cd "$dotfilesDirectory"

}

download_utils() {

    local tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_UTILS_URL" "$tmpFile" \
        && source "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

   return 1

}

extract() {

    local archive="$1"
    local outputDir="$2"

    if command -v "tar" &> /dev/null; then
        tar -zxf "$archive" --strip-components 1 -C "$outputDir"
        return $?
    fi

    return 1

}

is_supported_version() {

    declare -a v1=(${1//./ })
    declare -a v2=(${2//./ })
    local i=""

    # Fill empty positions in v1 with zeros
    for (( i=${#v1[@]}; i<${#v2[@]}; i++ )); do
        v1[i]=0
    done

    for (( i=0; i<${#v1[@]}; i++ )); do

        # Fill empty positions in v2 with zeros
        if [[ -z ${v2[i]} ]]; then
            v2[i]=0
        fi

        if (( 10#${v1[i]} < 10#${v2[i]} )); then
            return 1
        fi

    done

}

verify_os() {

    declare -r MINIMUM_OS_X_VERSION="10.10"
    declare -r MINIMUM_UBUNTU_VERSION="14.04"
    declare -r OS_NAME="$(uname -s)"

    declare OS_VERSION=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the OS is `OS X` and
    # it's above the required version

    if [ "$OS_NAME" == "Darwin" ]; then

        OS_VERSION="$(sw_vers -productVersion)"

        is_supported_version "$OS_VERSION" "$MINIMUM_OS_X_VERSION" \
            && return 0 \
            || printf "Sorry, this script is intended only for OS X $MINIMUM_OS_X_VERSION+"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the OS is `Ubuntu` and
    # it's above the required version

    elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then

        OS_VERSION="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"

        is_supported_version "$OS_VERSION" "$MINIMUM_UBUNTU_VERSION" \
            && return 0 \
            || printf "Sorry, this script is intended only for Ubuntu $MINIMUM_UBUNTU_VERSION+"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    else
        printf "Sorry, this script is intended only for OS X and Ubuntu!"
    fi

    return 1

}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    # Ensure the OS is supported and
    # it's above the required version

    verify_os || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure that the following actions
    # are made relative to this file's path
    #
    # http://mywiki.wooledge.org/BashFAQ/028

    cd "$(dirname "$BASH_SOURCE")"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Load utils

    if [ -x "os/utils.sh" ]; then
        source "os/utils.sh" || exit 1
    else
        download_utils || exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Setup the `dotfiles` if needed

    if ! cmd_exists "git" \
        || [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then

        print_info "Download and extract archive"
        download_dotfiles

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Create directories"

    ask_for_confirmation "Do you want the additional directories to be created?"
    printf "\n"

    if answer_is_yes; then
        ./os/create_directories.sh
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Create symbolic links"
    ./os/create_symbolic_links.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Install applications"

    ask_for_confirmation "Do you want to install the applications/command line tools?"
    printf "\n"

    if answer_is_yes; then

        ./os/install_applications.sh
        print_in_green "\n  ---\n\n"

        ./os/install_node_versions.sh
        print_in_green "\n  ---\n\n"

        ./os/install_npm_packages.sh

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Set preferences"

    ask_for_confirmation "Do you want to set the custom preferences?"
    printf "\n"

    if answer_is_yes; then
        ./os/set_preferences.sh
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "git"; then

        if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
            print_info "Initialize Git repository"
            ./os/initialize_git_repository.sh "$DOTFILES_ORIGIN"
        fi

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        print_info "Update content"

        ask_for_confirmation "Do you want to update the content from the "dotfiles" directory?"
        printf "\n"

        if answer_is_yes; then
            ./os/update_content.sh
        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "vim"; then

        print_info "Install/Update Vim plugins"

        ask_for_confirmation "Do you want to install/update the Vim plugins?"
        printf "\n"

        if answer_is_yes; then
            ./os/install_vim_plugins.sh
        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Restart"

    ask_for_confirmation "Do you want to restart?"
    printf "\n"

    if answer_is_yes; then
        ./os/restart.sh
    fi

}

main
