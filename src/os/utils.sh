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

execute() {

    local tmpFile="$(mktemp /tmp/XXXXX)"
    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    eval "$1" \
        &> /dev/null \
        2> "$tmpFile"

    print_result $? "${2:-$1}"
    exitCode=$?

    if [ $exitCode -ne 0 ]; then
        print_error_stream "↳ ERROR:" < "$tmpFile"
    fi

    rm -rf "$tmpFile"

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
        print_error "$1 $line"
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
