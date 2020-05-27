#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Credentials\n\n"

ask_for_confirmation "Overwrite credentials?"
if answer_is_yes; then
    ask_for_confirmation "Really really?"
    if answer_is_yes; then
        execute "lpass show CONFIG/aws-credentials --notes > ~/.aws/credentials"
        execute "lpass show CONFIG/aws-config --notes > ~/.aws/config"
        execute "lpass show CONFIG/mab-env --notes > ~/Work/docker/mab/.env"
        execute "lpass show CONFIG/mab-test-env --notes > ~/Work/docker/mab/.test-env"

        declare -a SSH_KEYS=(
            "id_rsa"
            "id_rsa_work"
            "id_rsa_otng"
        )

        for i in "${SSH_KEYS[@]}"; do
            execute "lpass show CONFIG/$i --field='Private Key' > ~/.ssh/$i"
            execute "lpass show CONFIG/$i --field='Public Key' > ~/.ssh/$i.pub"
        done

        execute "lpass show CONFIG/ssh-config --notes > ~/.ssh/config"
    fi
fi

execute "chmod 600 ~/.ssh/*"
execute "chmod 644 ~/.ssh/id_rsa*.pub"