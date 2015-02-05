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
* [Copy](os/copy_files.sh) / [Symlink](os/create_symbolic_links.sh) the
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

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6028893/83c92b82-abf5-11e4-922d-bded287db3d3.gif" alt="Setup process" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6066251/68211e00-ad74-11e4-88e0-62048ff12fad.gif" alt="Setup process" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>
<p align="center"><i>Setup process</i></p>


## Screenshots

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6067283/1a6c8d90-ad7c-11e4-9861-1178c4868f48.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6066368/4b6a2544-ad75-11e4-8192-a4d4b4e1d9e8.png" alt="Output for Git status on Ubuntu" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>
<p align="center"><i>Output for Git status</i></p>

<br>

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6067292/2768cac2-ad7c-11e4-9f7a-81c82fe5c993.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6066393/790aa5be-ad75-11e4-90d5-c346ba5981d6.png" alt="Output for Git log on OS X" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>
<p align="center"><i>Output for Git log</i></p>

<br>

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6067912/bfb4fb62-ad80-11e4-8980-2976663bb029.png" alt="MacVim" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6066432/a6ea920a-ad75-11e4-8650-14df975d8926.png" alt="Gnome Vim" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">MacVim</td>
            <td align="center">Gnome Vim</td>
        </tr>
    </tbody>
</table>
<p align="center"><i>gVim</i></p>

<br>

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6067336/5f804fb6-ad7c-11e4-8ccd-c7aaa83e25b5.png" alt="Vim on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6066455/ccff1c2c-ad75-11e4-8e0f-649b195aee60.png" alt="Vim on Ubuntu" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>
<p align="center"><i>Vim</i></p>


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
`dotfiles` script](https://github.com/alrra/dotfiles/blob/5b524ba9ca07b66db1955d18a2fb66bf4b48f677/dotfiles#L3).


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
