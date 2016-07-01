#!/bin/bash

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read -r
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -r -n 1
    printf "\n"
}

ask_for_sudo() {

    # Ask for the administrator password upfront
    sudo -v &> /dev/null

    # Update existing `sudo` time stamp until this script has finished
    # https://gist.github.com/cowboy/3118588
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &

}

cmd_exists() {
    command -v "$1" &> /dev/null
}

kill_all_subprocesses() {

    local i=""

    for i in $(jobs -p); do
        kill "$i"
        wait "$i" &> /dev/null
    done

}

execute() {

    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

    local exitCode=0
    local cmdsPID=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the current process is ended,
    # also end all its subprocesses

    set_trap "EXIT" "kill_all_subprocesses"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute commands in background

    eval "$CMDS" \
        &> /dev/null \
        2> "$TMP_FILE" &

    cmdsPID=$!

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Show a spinner if the commands
    # require more time to complete

    show_spinner "$cmdsPID" "$CMDS" "$MSG"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code

    wait "$cmdsPID" &> /dev/null
    exitCode=$?

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print output based on what happened

    print_result $exitCode "$MSG"

    if [ $exitCode -ne 0 ]; then
        print_error_stream < "$TMP_FILE"
    fi

    rm -rf "$TMP_FILE"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    return $exitCode

}

get_answer() {
    printf "%s" "$REPLY"
}

get_os() {

    local os=""
    local kernelName=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    kernelName="$(uname -s)"

    if [ "$kernelName" == "Darwin" ]; then
        os="macos"
    elif [ "$kernelName" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
        os="ubuntu"
    else
        os="$kernelName"
    fi

    printf "%s" "$os"

}

get_os_version() {

    local os=""
    local version=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    os="$(get_os)"

    if [ "$os" == "macos" ]; then
        version="$(sw_vers -productVersion)"
    elif [ "$os" == "ubuntu" ]; then
        version="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"
    fi

    printf "%s" "$version"

}

get_os_arch() {
    printf "%s" "$(getconf LONG_BIT)"
}

is_git_repository() {
    git rev-parse &> /dev/null
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

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 - a file with the same name already exists!"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    print_in_red "  [✖] $1 $2\n"
}

print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

print_in_green() {
    printf "\e[0;32m%b\e[0m" "$1"
}

print_in_purple() {
    printf "\e[0;35m%b\e[0m" "$1"
}

print_in_red() {
    printf "\e[0;31m%b\e[0m" "$1"
}

print_in_yellow() {
    printf "\e[0;33m%b\e[0m" "$1"
}

print_info() {
    print_in_purple "\n $1\n\n"
}

print_question() {
    print_in_yellow "  [?] $1"
}

print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

print_success() {
    print_in_green "  [✔] $1\n"
}

print_warning() {
    print_in_yellow "  [!] $1\n"
}

set_trap() {

    trap -p "$1" | grep "$2" &> /dev/null \
        || trap '$2' "$1"

}

skip_questions() {

     while :; do
        case $1 in
            -y|--yes) return 0;;
                   *) break;;
        esac
        shift 1
    done

    return 1

}

show_spinner() {

    local -r FRAMES='/-\|'

    # shellcheck disable=SC2034
    local -r NUMBER_OR_FRAMES=${#FRAMES}

    local -r CMDS="$2"
    local -r MSG="$3"
    local -r PID="$1"

    local frameText=""
    local frameTextLenght=0
    local i=0
    local j=0
    local numberOfLinesToBeCleared=0
    local terminalWindowWidth=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # For commands that require sudo, if the password needs to be
    # provided, wait for the user to provide it before showing the
    # actual spinner
    #
    # (this is kinda hacky, but yeah...)

    if printf "%s" "$CMDS" | grep "sudo" &>/dev/null; then
        while kill -0 "$PID" &>/dev/null \
                && ! sudo -n true &> /dev/null; do
            sleep 0.2
        done
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Display spinner while the commands are being executed

    while kill -0 "$PID" &>/dev/null; do

        frameText="  [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"
        numberOfLinesToBeCleared=1

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Print frame text

        printf "%s" "$frameText"
        sleep 0.2

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Clear frame text

        # Notes:
        #
        #  * After the content surpasses the initial terminal height
        #    (the content forces the scroll), `tput sc` (save the cursor
        #    position) and `tput rc` (restore the cursor position) will
        #    no longer be reliable
        #
        # * `tput ed` (clear to end of screen) seems to also not always
        #    be reliable
        #
        # So, in order to work around the shortcomings described above,
        # the clearing of the previous printed content will have to be
        # done "manually".

        # The content may not fit into a single line so there is a
        # need to determine on how many lines it is printed on and
        # clear every single one of those lines

        terminalWindowWidth=$(tput cols)
        frameTextLenght=${#frameText}

        if [ "$terminalWindowWidth" -lt "$frameTextLenght" ]; then
            numberOfLinesToBeCleared=$(( numberOfLinesToBeCleared + ( frameTextLenght / terminalWindowWidth ) ))
        fi

        for j in $(seq 1 $numberOfLinesToBeCleared); do

            # Clear current line

            tput el     # Clear to end of line
            tput el1    # Clear to beginning of line

            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

            # The following line is just so that things look ok on
            # the Travis CI site. The line isn't really needed, but
            # also it doesn't do any harm. However, without it all
            # the frames of the spinner will just be displayed one
            # after the other in a single line.

            printf "\r"

            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

            # Move up one line if the line containing the starting
            # position of the content has not been reached

            if [ "$j" -lt "$numberOfLinesToBeCleared" ]; then
                tput cuu1
            fi

        done

    done

}
