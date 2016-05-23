#!/bin/bash

declare -r GITHUB_REPOSITORY="alrra/dotfiles"

declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare dotfilesDirectory="$HOME/projects/dotfiles"
declare skipQuestions=false

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

    local tmpFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_TARBALL_URL" "$tmpFile"
    print_result $? "Download archive" "true"
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! $skipQuestions; then

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

    else

        rm -rf "$dotfilesDirectory" &> /dev/null

    fi

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

    cd "$dotfilesDirectory/src/os" \
        || return 1

}

download_utils() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"

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

    local os_name=""
    local os_version=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the OS is `OS X` and
    # it's above the required version

    os_name="$(uname -s)"

    if [ "$os_name" == "Darwin" ]; then

        os_version="$(sw_vers -productVersion)"

        if is_supported_version "$os_version" "$MINIMUM_OS_X_VERSION"; then
            return 0
        else
            printf "Sorry, this script is intended only for OS X %s+" "$MINIMUM_OS_X_VERSION"
        fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the OS is `Ubuntu` and
    # it's above the required version

    elif [ "$os_name" == "Linux" ] && [ -e "/etc/lsb-release" ]; then

        os_version="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"

        if is_supported_version "$os_version" "$MINIMUM_UBUNTU_VERSION"; then
            return 0
        else
            printf "Sorry, this script is intended only for Ubuntu %s+" "$MINIMUM_UBUNTU_VERSION"
        fi

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

    while :; do
        case $1 in
            -y|--yes) skipQuestions=true; break;;
                   *) break;;
        esac
        shift 1
    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure that the following actions
    # are made relative to this file's path
    #
    # http://mywiki.wooledge.org/BashFAQ/028

    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Load utils

    if [ -x "utils.sh" ]; then
        source "utils.sh" || exit 1
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
    ./create_directories.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Create symbolic links"

    if ! $skipQuestions; then
        ./create_symbolic_links.sh
    else
        ./create_symbolic_links.sh -y
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Install applications"

    ./install_applications.sh
    print_in_green "\n  ---\n\n"

    ./install_node_versions.sh
    print_in_green "\n  ---\n\n"

    ./install_npm_packages.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Set preferences"

    ./set_preferences.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "git"; then

        if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
            print_info "Initialize Git repository"
            ./initialize_git_repository.sh "$DOTFILES_ORIGIN"
        fi

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        if ! $skipQuestions; then

            print_info "Update content"

            ask_for_confirmation "Do you want to update the content from the 'dotfiles' directory?"
            printf "\n"

            if answer_is_yes; then
                ./update_content.sh
            fi

        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "vim"; then

        print_info "Install/Update Vim plugins"
        ./install_vim_plugins.sh

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


    if ! $skipQuestions; then

        print_info "Restart"

        ask_for_confirmation "Do you want to restart?"
        printf "\n"

        if answer_is_yes; then
            ./restart.sh
        fi

    fi

}

main "$@"
