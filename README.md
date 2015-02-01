# Cătălin’s dotfiles (WIP)

## Setup

To setup the dotfiles, run the following snippet in the terminal:

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |

The snippet will:

* Download the dotfiles on your computer (by default it will suggest
  `~/projects/dotfiles`)
* Create some additional [directories](os/create_directories.sh)
* [Symlink](os/create_symbolic_links.sh)/[Copy](os/copy_files.sh) the
  [git](git),
  [shell](shell), and
  [vim](vim) files
* Install applications / command-line tools for
  [OS X](os/os_x/install_applications.sh) /
  [Ubuntu](os/ubuntu/install_applications.sh)
* Set custom
  [OS X](os/os_x/set_preferences.sh) /
  [Ubuntu](os/ubuntu/set_preferences.sh) preferences
* Install [vim plugins](vim/vim/plugins)


## Screenshots

<p>
  <img src="https://cloud.githubusercontent.com/assets/1223565/5976910/829e3994-a89b-11e4-9854-eadf6ceb20d9.png" alt="Output for Git status">
  <p align="center"><i>Output for Git status</i></p>
</p>

<br>
<p>
  <img src="https://cloud.githubusercontent.com/assets/1223565/5976900/628bc7a2-a89b-11e4-8c63-d8081dc345b7.png" alt="Output for Git log">
  <p align="center"><i>Output for Git log</i></p>
</p>

<br>
<p>
  <img src="https://cloud.githubusercontent.com/assets/1223565/5976899/628b4cfa-a89b-11e4-99a3-2a8970de0b13.png" alt="MacVim">
  <p align="center"><i>MacVim</i></p>
</p>

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local
requirements by using the following files:

#### `~/.bash.local`

If the `~/.bash.local` file exist, it will be automatically sourced
after all the other [bash related
files](https://github.com/alrra/dotfiles/tree/master/shell), thus,
allowing its content to add to or overwrite the existing aliases,
settings, PATH, etc.

Here is a very simple example of a `~/.bash.local` file:

```bash

#!/bin/bash

declare -r GIT_USER_EMAIL="alrra@example.com"
declare -r GIT_USER_NAME="Cătălin Mariș"

# ----------------------------------------------------------------------

# Set local aliases

alias starwars="telnet towel.blinkenlights.nl"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set local Git credentials

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set PATH additions

PATH="/usr/local/bin:$PATH"
PATH="$PATH:$HOME/projects/dotfiles/bin"

export PATH
```

#### `~/.vimrc.local`

If the `~/.vimrc.local` file exist, it will be automatically sourced
after `~/.vimrc`, thus, allowing its content to add or overwrite the
settings from `~/.vimrc`.

#### `~/.gvimrc.local`

Same as `~/.vimrc.local` but for `~/.gvimrc`.

### Forks

If you decide to fork this project, don't forget to substitute my
username with your own in the [setup snippets](#setup) and [in the
`dotfiles` script](https://github.com/alrra/dotfiles/blob/8a1e4a2a0d9206026bcd4c0f2e0d158214495b16/dotfiles#L3).


## Update

To update the dotfiles, just run the [`dotfiles`](dotfiles) script.

```bash
$ ./dotfiles
```

The update process will do basically the same things as setup,
but instead of downloading the dotfiles, it will just fetch the
latest changes.


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Mathias Bynens'](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher's](https://github.com/necolas)
  [dotfiles](https://github.com/necolas/dotfiles)
