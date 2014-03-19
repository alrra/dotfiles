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
declare force=1 # false by default
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
    log_question "$1"
    read
}

ask_for_confirmation() {
    log_question "$1 (y/n) "
    read -n 1
    printf "\n"
}

ask_for_confirmation_if_needed() {
    if [ $force -eq 1 ]; then
        ask_for_confirmation "$1"
    fi

    if [ $force -eq 0 ] || \
       [ $(answer_is_yes; printf $?) -eq 0 ]; then
        return 0
    fi

    return 1
}

check_github_ssh_key() {

    local github_ssh_url="https://github.com/settings/ssh"
    local ssh_key_file="id_rsa.pub"

    if [ "$(ssh -T git@github.com &> /dev/null; printf $?)" -ne 1 ]; then

        cd "$HOME/.ssh"

        # Setup GitHub SSH Key
        # https://help.github.com/articles/generating-ssh-keys

        log_info "Set up the SSH key"

        if [ ! -r "$ssh_key_file" ]; then
            rm -rf "$ssh_key_file"
            ask "Please provide an email address (email): " && printf "\n"
            ssh-keygen -t rsa -C "$(get_answer)"
        fi

        if [ "$os" == "osx" ]; then

            # Copy SSH key to clipboard
            cat "$ssh_key_file" | pbcopy
            log_result $? "Copy SSH key to clipboard"

            # Open the GitHub web page where the SSH key can be added
            open "$github_ssh_url"

        elif [ "$os" == "ubuntu" ]; then

            # Copy SSH key to clipboard
            cat "$ssh_key_file" | xclip -selection clip
            log_result $? "Copy SSH key to clipboard"

            # Open the GitHub web page where the SSH key can be added
            xdg-open "$github_ssh_url"

        fi

        # Before proceeding, wait for everything to be ok
        while [ "$(ssh -T git@github.com &> /dev/null; printf $?)" -ne 1 ]; do
            sleep 5;
        done

        log_success "Set up the SSH key"
    fi

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
        if [ $(compare_versions "$(sw_vers -productVersion)" "10.9") == '<' ]; then
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

compare_versions() {

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

        if (( 10#${v1[i]} > 10#${v2[i]} )); then
            printf ">"
            return 0;
        fi

        if (( 10#${v1[i]} < 10#${v2[i]} )); then
            printf "<"
            return 0;
        fi
    done

    printf "="

}

copy_files() {
    place_files "cp -f" "${FILES_TO_COPY[@]}"
}

create_directories() {
    ask_for_confirmation_if_needed "Do you want the additional directories to be created?"
    if [ $? -eq 0 ]; then
        for i in ${NEW_DIRECTORIES[@]}; do
            mkd "$i"
        done
    fi
}

create_symbolic_links() {
    place_files "ln -fs" "${FILES_TO_SYMLINK[@]}"
}

download_and_extract_archive() {

    local tmpFile="$(mktemp -u XXXXX)"

    cd '/tmp'

    # Download archive
    if [ "$os" == "osx" ]; then

        curl -LsSo "$tmpFile" "$DOTFILES_ARCHIVE_URL"
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

    elif [ "$os" == "ubuntu" ]; then

        wget -qO "$tmpFile" "$DOTFILES_ARCHIVE_URL"
        #     │└─ write output to file
        #     └─ don't show output

    fi

    log_result $? "Download archive" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_confirmation "Do you want to store the dotfiles in '$dotfiles_directory'?"
    if ! answer_is_yes; then
        ask "Please specify another location for the dotfiles (path):"
        dotfiles_directory="$(get_answer)"
    fi

    # Ensure the `dotfiles` directory is available
    if [ -e "$dotfiles_directory" ]; then
        while [ -e "$dotfiles_directory" ]; do

            ask_for_confirmation "'$dotfiles_directory' already exists! Do you want to overwrite it?"

            if answer_is_yes; then
                rm -rf "$dotfiles_directory"
                break
            else
                ask "Please specify another location for the dotfiles (path)"
                dotfiles_directory="$(get_answer)"
            fi
        done
    fi

    mkd "$dotfiles_directory"

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

get_answer() {
    printf "$REPLY"
}

git_initialize_repository() {
    cd "$dotfiles_directory"
    if ! is_git_repository; then
        git init &> /dev/null \
            && git remote add origin "$DOTFILES_GIT_REMOTE" &> /dev/null
        log_result $? "Initialize the 'dotfiles' git repository"
    fi
}

git_update_content() {
    cd "$dotfiles_directory"
    if is_git_repository; then

        ask_for_confirmation_if_needed "Do you want to update the content from the 'dotfiles' directory?"

        if [ $? -eq 0 ]; then
            check_github_ssh_key
            cd "$dotfiles_directory"

            # Update content, remove untracked files and fetch submodules
            git fetch --all &> /dev/null \
                && git reset --hard origin/master &> /dev/null \
                && git clean -fd  &> /dev/null \
                && git submodule update --recursive --init --quiet &> /dev/null \

            log_result $? "Update content"
        fi

    fi
}

install_apps() {

    if [ "$os" == "osx" ]; then
        source "$dotfiles_directory/lib/osx/install_applications.sh"
    elif [ "$os" == "ubuntu" ]; then
        source "$dotfiles_directory/lib/ubuntu/install_applications.sh"
    fi

    ask_for_confirmation_if_needed "Do you want to install the applications/command line tools?"
    [ $? -eq 0 ] && install_applications

}

is_git_repository() {
    if [ $(git rev-parse --is-inside-work-tree &> /dev/null; printf "%s" $?) == 0 ]; then
        return 0;
    else
        return 1;
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

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

log_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

log_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
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
        ask_for_confirmation_if_needed "'$3' already exists! Do you want to overwrite it?"
        if [ $? -eq 0 ]; then
            rm -rf "$3"
            execute "$1 $2 $3" "$3 → $2"
        else
            log_error "$3 → $2"
        fi
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
        [ $force -eq 1 ] && [ "$i" != "${files[0]}" ] && printf "\n"
        sourceFile="$dotfiles_directory/$i"
        targetFile=$(printf "%s" "$HOME/.$i" | sed "s/.*\/\(.*\)/\1/g")
        place_file "$cmd" "$sourceFile" "$HOME/.$targetFile"
    done

}

set_custom_preferences() {

    if [ "$os" == "osx" ]; then
        source "$dotfiles_directory/lib/osx/set_preferences.sh"
    elif [ "$os" == "ubuntu" ]; then
        source "$dotfiles_directory/lib/ubuntu/set_preferences.sh"
    fi

    ask_for_confirmation_if_needed "Do you want to set the custom preferences?"
    [ $? -eq 0 ] && set_preferences
}

# ##############################################################################
# # MAIN                                                                       #
# ##############################################################################

main() {

    local process=""

    # Ensure the OS is OS X 10.9.0+ or Ubuntu
    check_os || exit;

    # Parse commandline arguments
    # http://wiki.bash-hackers.org/howto/getopts_tutorial
    while getopts ":f" option; do
        case "$option" in
             f) declare force=0 ;;
            \?) printf "Invalid option: -%s" "$OPTARG" &> /dev/null; exit 1 ;;
        esac
    done

    cd "${BASH_SOURCE%/*}"
    #     └─ see: http://mywiki.wooledge.org/BashFAQ/028

    # Determine if the `dotfiles` need to be set up or updated
    if [ $(cmd_exists "git") -eq 0 ] && \
       [ "$(git config --get remote.origin.url)" == "$DOTFILES_GIT_REMOTE" ]; then

        process="update"
        dotfiles_directory="$(cd .. && pwd)"

        log_info "Update content"
        git_update_content

    else

        process="setup"

        log_info "Download and extract archive"
        download_and_extract_archive

    fi

    log_info "Create directories"
    create_directories

    log_info "Copy files"
    copy_files

    log_info "Create symbolic links"
    create_symbolic_links

    # Ask for the administrator password upfront
    sudo -v

    # Update existing `sudo` time stamp until this script has finished
    # (https://gist.github.com/3118588)
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    log_info "Install applications"
    install_apps

    log_info "Set preferences"
    set_custom_preferences

    if [ "$process" == "setup" ]; then
        log_info "Initialize git repository"
        git_initialize_repository

        log_info "Update content"
        git_update_content
    fi

    log_info "All done."

    ask_for_confirmation "Do you want to restart?"

    if answer_is_yes; then
        log_info "Restarting..."
        sudo shutdown -r now
    fi

    printf "\n"

}

main $@
