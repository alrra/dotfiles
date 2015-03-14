# [Cătălin](https://github.com/alrra)’s dotfiles

## Setup

To setup the dotfiles just run one of the following snippets in the terminal:

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |

That's it! :sparkles:

The setup process will:

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
                <img src="https://cloud.githubusercontent.com/assets/1223565/6079359/df4df582-ae0c-11e4-8643-db7c251284d6.gif" alt="Setup process" width="100%">
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


## Screenshots


##### Output for Git status

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263679/82b79a6e-b823-11e4-8211-9e55e971ca4d.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263677/82b4d432-b823-11e4-9832-69a27da75dda.png" alt="Output for Git status on Ubuntu" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>


##### Output for Git log

  <table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263680/82b7ecd0-b823-11e4-80cb-c0b59879a809.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263681/82ba0d80-b823-11e4-9cc0-e722fe340fb4.png" alt="Output for Git log on OS X" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>


##### gVim

  <table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263678/82b76a26-b823-11e4-866b-f7c3605d6225.png" alt="MacVim" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263675/828dc78e-b823-11e4-86b1-d5116a8868c2.png" alt="Gnome Vim" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X (MacVim)</td>
            <td align="center">Ubuntu (Gnome Vim)</td>
        </tr>
    </tbody>
</table>


##### Vim

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263682/82ce0128-b823-11e4-95f4-5b78d5e13ffb.png" alt="Vim on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/6263676/82b4346e-b823-11e4-867b-260be48c5771.png" alt="Vim on Ubuntu" width="100%">
            </td>
        </tr>
        <tr>
            <td align="center">OS X</td>
            <td align="center">Ubuntu</td>
        </tr>
    </tbody>
</table>


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

The update process will do basically the same things as [setup](#setup),
but instead of downloading the dotfiles, it will just fetch the
latest changes.


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Mathias Bynens'](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher's](https://github.com/necolas)
  [dotfiles](https://github.com/necolas/dotfiles)


## License

The code is available under the [MIT license](LICENSE.md).
