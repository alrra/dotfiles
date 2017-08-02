#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

ask_for_sudo

print_in_purple "\n Python\n\n"

brew_install "python" "python"
brew_install "python3" "python3"

print_in_purple "\n Setting up pip\n\n"
easy_install pip

print_in_purple "\n Setup virtual environments\n\n"

# Install virtual environments globally
# It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
export PIP_REQUIRE_VIRTUALENV=false
print_in_purple "\n Install virtualenv\n\n"
pip install virtualenv
print_in_purple "\n Install virtualenvwrapper\n\n"
pip install virtualenvwrapper

BASH_PROFILE_PATH=~/.bash_profile
print_in_purple "Source virtualenvwrapper from ~/.extra"
EXTRA_PATH=~/.extra
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
echo "" >> $BASH_PROFILE_PATH
source $EXTRA_PATH

print_in_purple "\n Setting up Python 2 virtual environment\n\n"
mkvirtualenv py2-data
workon py2-data

print_in_purple "\n Setting up Python 3 virtual environment\n\n"
mkvirtualenv --python=/usr/local/bin/python3 py3-data
workon py3-data
pip3 install gitsome

print_in_purple "Usage: workon py2-data for Python 2\n"
print_in_purple "Usage: workon py3-data for Python 3\n"
