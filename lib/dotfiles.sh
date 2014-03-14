#!/bin/bash

declare -r DOTFILES_ARCHIVE_URL="https://github.com/alrra/dotfiles/tarball/master"
declare -r DOTFILES_GIT_REMOTE="git@github.com:alrra/dotfiles.git"

declare -a FILES_TO_COPY=(
    "git/gitconfig"
)

declare -a FILES_TO_SYMLINK=(
    "shell/bash_aliases"
    "shell/bash_functions"
    "shell/bash_exports"
    "shell/bash_prompt"
    "shell/bash_profile"
    "shell/bash_logout"
    "shell/bashrc"
    "shell/hushlogin"
    "shell/inputrc"

    "git/gitattributes"
    "git/gitignore"

    "vim/vim"
    "vim/vimrc"
    "vim/gvimrc"
)

declare -a NEW_DIRECTORIES=(
    "$HOME/archive"
    "$HOME/Downloads/torrents"
    "$HOME/projects"
    "$HOME/server"
)

declare dotfiles_directory="$HOME/projects/dotfiles"
declare os=""

# ##############################################################################
# # HELPER FUNCTIONS                                                           #
# ##############################################################################

answer_is_yes() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

ask() {
    read -p "  [?] $1 "
}

ask_for_confirmation() {
    read -p "  [?] $1 " -n 1
    printf "\n"
}

check_os() {
    if [ "$(uname -s)" != "Darwin" ]; then
        if [ "$(uname -s)" != "Linux" ] || [ ! -e "/etc/lsb-release" ]; then
            log_error "Sorry, this script is intended only for OS X and Ubuntu!"
            return 1
        else
            os="ubuntu"
            return 0
        fi
    else
        if [ "10.9" = "$(printf '%s\n%s' '10.9' '$(sw_vers -productVersion)' | sort | head -n1)" ]; then
            log_error "Sorry, this script is intended only for OS X 10.9.0+."
            return 1
        else
            os="osx"
            return 0
        fi
    fi
}

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 0 \
        || printf 1
}

copy_files() {
    log_info "Copying files..."
    place_files "cp -f" "${FILES_TO_COPY[@]}"
}

create_directories() {
    log_info "Creating directories..."
    for i in ${NEW_DIRECTORIES[@]}; do
        mkd "$i"
    done
}

create_symbolic_links() {
    log_info "Creating symbolic links..."
    place_files "ln -fs" "${FILES_TO_SYMLINK[@]}"
}

get_answer() {
    printf "$REPLY"
}

download_and_extract_archive() {

    local tmpFile="$(mktemp -u XXXXX)"

    log_info "Downloading and extracting archive..."

    cd '/tmp'

    # Download archive
    if [ "$os" = "osx" ]; then

        curl -LsSo "$tmpFile" "$DOTFILES_ARCHIVE_URL"
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

    elif [ "$os" = "ubuntu" ]; then

        wget -qO "$tmpFile" "$DOTFILES_ARCHIVE_URL"
        #     │└─ write output to file
        #     └─ don't show output

    fi

    log_result $? "Download archive" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure the `dotfiles` directory is available
    if [ -e "$dotfiles_directory" ]; then
        while [ -e "$dotfiles_directory" ]; do

            log_warning "'$dotfiles_directory' already exists!"
            ask_for_confirmation "Do you want to overwrite it? (y/n)"

            if answer_is_yes; then
                rm -rf "$dotfiles_directory"
                mkd "$dotfiles_directory"
                break
            else
                ask "Please specify another location for the dotfiles (path):"
                dotfiles_directory="$(get_answer)"
            fi
        done
    else
        mkd "$dotfiles_directory"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Extract archive to the `dotfiles` directory
    tar -zxf "$tmpFile" --strip-components 1 -C "$dotfiles_directory"
    log_result $? "Extract archive" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Remove the archive
    rm -rf "$tmpFile"
    log_result $? "Remove archive"

}

execute() {
    $1 &> /dev/null
    log_result $? "${2:-$1}"
}

execute_str() {
    sudo sh -c "$1" &> /dev/null
    log_result $? "${2:-$1}"
}

is_git_repository() {
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then
        return 0;
    else
        return 1;
    fi
}

git_initialize_repository() {

    cd "$dotfiles_directory"

    if ! is_git_repository; then

        log_info "Initializing the git repository..."

        git init &> /dev/null \
            && git remote add origin "$DOTFILES_GIT_REMOTE" &> /dev/null
        log_result $? "Initialize git repository"

    fi
}

git_update_content() {

    cd "$dotfiles_directory"

    if is_git_repository; then

        log_info "Updating content..."

        # Update content, remove untracked files and fetch submodules
        git fetch --all &> /dev/null \
            && git reset --hard origin/master &> /dev/null \
            && git clean -fd  &> /dev/null \
            && git submodule update --recursive --init --quiet &> /dev/null \

        log_result $? "Update content"
    fi
}

log_error() {
    # Print output in red
    printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

log_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

log_result() {
    [ $1 -eq 0 ] \
        && log_success "$2" \
        || log_error "$2"

    [ "$3" = "true" ] && [ $1 -ne 0 ] \
        && exit
}

log_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

log_warning() {
    # Print output in yellow
    printf "\e[0;33m  [!] $1\e[0m\n"
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                log_error "$1 - a file with the same name already exists!"
            else
                log_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

place_file() {
    if [ -e "$3" ]; then

        log_warning "'$3' already exists!"
        ask_for_confirmation "do you want to overwrite it? (y/n)"

        if answer_is_yes; then
            rm -rf "$3"
            execute "$1 $2 $3" "$3 → $2"
        else
            log_error "$3 → $2"
        fi

        printf "\n"
    else
        execute "$1 $2 $3" "$3 → $2"
    fi
}

place_files() {

    local cmd=$1
    local sourceFile="", targetFile=""

    shift 1
    declare -a files=("$@")

    for i in ${files[@]}; do
        sourceFile="$dotfiles_directory/$i"
        targetFile=$(printf "%s" "$HOME/.$i" | sed "s/.*\/\(.*\)/\1/g")
        place_file "$cmd" "$sourceFile" "$HOME/.$targetFile"
    done

}

set_custom_preferences_and_install_apps() {

    # Ask for the administrator password upfront
    sudo -v

    # Update existing `sudo` time stamp until this script has finished
    # (https://gist.github.com/3118588)
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    if [ "$os" == "osx" ]; then

        source "$dotfiles_directory/lib/osx/install_applications.sh"
        install_applications

        source "$dotfiles_directory/lib/osx/set_preferences.sh"
        set_preferences

    elif [ "$os" != "ubuntu" ]; then

        source "$dotfiles_directory/lib/ubuntu/install_applications.sh"
        install_applications

        source "$dotfiles_directory/lib/ubuntu/set_preferences.sh"
        set_preferences

    fi

}


# ##############################################################################
# # MAIN                                                                       #
# ##############################################################################

main() {

    local process=""

    # Ensure the OS is OS X 10.9.0+ or Ubuntu
    check_os || exit;

    cd "${BASH_SOURCE%/*}"
    #     └─ see: http://mywiki.wooledge.org/BashFAQ/028

    # Determine if the `dotfiles` need to be set up or updated
    if [ $(cmd_exists "git") -eq 0 ] && \
       [ "$(git config --get remote.origin.url)" = "$DOTFILES_GIT_REMOTE" ]; then
        process="update"
        dotfiles_directory="$(cd .. && pwd)"
        git_update_content
    else
        process="setup"
        download_and_extract_archive
    fi

    create_directories
    copy_files
    create_symbolic_links
    set_custom_preferences_and_install_apps

    if [ "$process" = "setup" ]; then
        git_initialize_repository
        git_update_content
    fi

    log_info "All done."

    ask_for_confirmation "Do you want to restart? (y/n)"

    if answer_is_yes; then
        log_info "Restarting..."
        sudo shutdown -r now
    fi

    printf "\n"

}

main
