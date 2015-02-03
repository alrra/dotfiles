#!/bin/bash

cd "${BASH_SOURCE%/*}" && source "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

check_github_ssh_key() {

    declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"
    local ssh_key_file="id_rsa.pub"
    local path="$(pwd)"

    [ "$(ssh -T git@github.com &> /dev/null; printf $?)" -eq 1 ] && return

    cd "$HOME/.ssh"

    # Setup GitHub SSH Key
    # https://help.github.com/articles/generating-ssh-keys

    print_info "Set up the SSH key"

    if [ ! -r "$ssh_key_file" ]; then
        rm -rf "$ssh_key_file"
        ask "Please provide an email address (email): " && printf "\n"
        ssh-keygen -t rsa -C "$(get_answer)"
    fi

    if [ $(cmd_exists "open") -eq 0 ] &&
       [ $(cmd_exists "pbcopy") -eq 0 ]; then

        # Copy SSH key to clipboard
        cat "$ssh_key_file" | pbcopy
        print_result $? "Copy SSH key to clipboard"

        # Open the GitHub web page where the SSH key can be added
        open "$GITHUB_SSH_URL"

    elif [ $(cmd_exists "xclip") -eq 0 ] &&
         [ $(cmd_exists "xdg-open") -eq 0 ]; then

        # Copy SSH key to clipboard
        cat "$ssh_key_file" | xclip -selection clip
        print_result $? "Copy SSH key to clipboard"

        # Open the GitHub web page where the SSH key can be added
        xdg-open "$GITHUB_SSH_URL"

    fi

    # Before proceeding, wait for everything to be ok
    while [ "$(ssh -T git@github.com &> /dev/null; printf $?)" -ne 1 ]; do
        sleep 5;
    done

    cd $path
    print_success "Set up the SSH key"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if is_git_repository; then

        check_github_ssh_key

        # Update content, remove untracked files and fetch submodules
        git fetch --all &> /dev/null \
            && git reset --hard origin/master &> /dev/null \
            && git clean -fd  &> /dev/null

        print_result $? "Update content"

    fi

}

main
