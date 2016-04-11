#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "gsettings set com.canonical.Unity.Lenses remote-content-search 'none'" \
        "Turn off 'Remote Search' so that search terms in Dash do not get sent over the internet"

    execute "gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false" \
        "Disable Dash 'More suggestions' section"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '  Privacy\n\n'
    set_preferences

}

main
