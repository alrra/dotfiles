#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Create data URI from a file.

datauri() {

    local mimeType=""

    if [ -f "$1" ]; then
        mimeType=$(file -b --mime-type "$1")
        #                └─ do not prepend the filename to the output

        if [[ $mimeType == text/* ]]; then
            mimeType="$mimeType;charset=utf-8"
        fi

        printf "data:%s;base64,%s" \
                    "$mimeType" \
                    "$(openssl base64 -in "$1" | tr -d "\n")"
    else
        printf "%s is not a file.\n" "$1"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Delete files that match a certain pattern from the current directory.

delete-files() {
    local q="${1:-*.DS_Store}"
    find . -type f -name "$q" -ls -delete
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get gzip information (gzipped file size + reduction size).

gz() {

    declare -i gzippedSize=0
    declare -i originalSize=0

    if [ -f "$1" ]; then
        if [ -s "$1" ]; then

            originalSize=$( wc -c < "$1" )
            printf "\n original size:   %12s\n" "$(hrfs "$originalSize")"

            gzippedSize=$( gzip -c "$1" | wc -c )
            printf " gzipped size:    %12s\n" "$(hrfs "$gzippedSize")"

            printf " ─────────────────────────────\n"
            printf " reduction:       %12s [%s%%]\n\n" \
                        "$( hrfs $((originalSize - gzippedSize)) )" \
                        "$( printf "%s" "$originalSize $gzippedSize" | \
                            awk '{ printf "%.1f", 100 - $2 * 100 / $1 }' | \
                            sed -e "s/0*$//;s/\.$//" )"
                            #              └─ remove tailing zeros

        else
            printf "\"%s\" is empty.\n" "$1"
        fi
    else
        printf "\"%s\" is not a file.\n" "$1"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Human readable file size
# (because `du -h` doesn't cut it for me).

hrfs() {

    printf "%s" "$1" |
    awk '{
            i = 1;
            split("B KB MB GB TB PB EB ZB YB WTFB", v);
            value = $1;

            # confirm that the input is a number
            if ( value + .0 == value ) {

                while ( value >= 1024 ) {
                    value/=1024;
                    i++;
                }

                if ( value == int(value) ) {
                    printf "%d %s", value, v[i]
                } else {
                    printf "%.1f %s", value, v[i]
                }

            }
        }' |
    sed -e ":l" \
        -e "s/\([0-9]\)\([0-9]\{3\}\)/\1,\2/; t l"
    #    └─ add thousands separator
    #       (changes "1023.2 KB" to "1,023.2 KB")
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Create new directories and enter the first one.

mkd() {
    if [ -n "$*" ]; then

        mkdir -p "$@"
        #      └─ make parent directories if needed

        cd "$@" \
            || exit 1

    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Search history.

qh() {
    #           ┌─ enable colors for pipe
    #           │  ("--color=auto" enables colors only if
    #           │  the output is in the terminal)
    grep --color=always "$*" "$HISTFILE" |       less -RX
    # display ANSI color escape sequences in raw form ─┘│
    #       don't clear the screen after quitting less ─┘
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Search for text within the current directory.

qt() {
    grep -ir --color=always "$*" --exclude-dir=".git" --exclude-dir="node_modules" . | less -RX
    #     │└─ search all files under each directory, recursively
    #     └─ ignore case
}
