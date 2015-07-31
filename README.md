# [Cătălin](https://github.com/alrra)’s dotfiles

These are the base dotfiles that I start with when I set up a
new environment. For more specific local needs I use the `.local`
files described in the [`Local Settings`](#local-settings) section.


## Setup

To setup the dotfiles just run the appropriate snippet in the
terminal:

(:warning: **DO NOT** run the setup snippet if you don't fully
understand [what it does](dotfiles). Seriously, **DON'T**!)

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |

That's it! :sparkles:

The setup process will:

* Download the dotfiles on your computer (by default it will suggest
  `~/projects/dotfiles`)
* Create some additional [directories](os/create_directories.sh)
* [Symlink](os/create_symbolic_links.sh) the
  [git](git),
  [shell](shell), and
  [vim](vim) files
* Install applications / command-line tools for
  [OS X](os/os_x/installs/main.sh) /
  [Ubuntu](os/ubuntu/installs/main.sh)
* Set custom
  [OS X](os/os_x/preferences/main.sh) /
  [Ubuntu](os/ubuntu/preferences/main.sh) preferences
* Install [vim plugins](vim/vim/plugins)

<table>
    <tbody>
        <tr><td colspan="2">Setup process in action</tr></td>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8509030/c79a6fd2-2293-11e5-8132-46effb733dfa.gif" alt="Setup process on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8509024/ac135b5c-2293-11e5-8bac-f10103af2948.gif" alt="Setup process on Ubuntu" width="100%">
            </td>
        </tr>
    </tbody>
</table>


## Screenshots


##### Git

<table>
    <tbody>
        <tr><td colspan="2">Output for Git status</tr></td>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397253/3bbaa172-1dce-11e5-954c-bca125d21850.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397636/3708d218-1ddb-11e5-9d40-21c6871271b9.png" alt="Output for Git status on Ubuntu" width="100%">
            </td>
        </tr>
    </tbody>
</table>

<table>
    <tbody>
        <tr><td colspan="2">Output for Git log</tr></td>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397255/504bef92-1dce-11e5-8f2b-714a0e57618b.png" alt="Output for Git status on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397637/40828b68-1ddb-11e5-94b6-4dd7aab105d8.png" alt="Output for Git log on Ubuntu" width="100%">
            </td>
        </tr>
    </tbody>
</table>


##### tmux

<table>
    <tbody>
        <tr>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397259/87914cea-1dce-11e5-8cf8-f01abf00bd1e.png" alt="tmux on OS X" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397811/fe821aac-1de0-11e5-8d9c-cb08f2b409df.png" alt="tmux on Ubuntu" width="100%">
            </td>
        </tr>
    </tbody>
</table>


##### vim

<table>
    <tbody>
        <tr>
            <td>
               <img src="https://cloud.githubusercontent.com/assets/1223565/8397632/20ae8922-1ddb-11e5-8a68-d61c8ab1b404.png" alt="MacVim" width="100%">
            </td>
            <td>
                <img src="https://cloud.githubusercontent.com/assets/1223565/8397645/54e1b99e-1ddb-11e5-80e1-8de3bfc19a68.png" alt="Gnome Vim" width="100%">
            </td>
        </tr>
    </tbody>
</table>


## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local
requirements by using the following files:

#### `~/.bash.local`

If the `~/.bash.local` file exists, it will be automatically sourced
after all the other [bash related files](shell), thus, allowing its
content to add to or overwrite the existing aliases, settings, PATH,
etc.

Here is a very simple example of a `~/.bash.local` file:

```bash

#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set local aliases

alias starwars="telnet towel.blinkenlights.nl"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set PATH additions

PATH="/usr/local/bin:$PATH"
PATH="$PATH:$HOME/projects/dotfiles/bin"

export PATH

```

#### `~/.gitconfig.local`

If the `~/.gitconfig.local` file exists, it will be automatically
included after the configurations from `~/.gitconfig`, thus, allowing
its content to overwrite or add to the existing `git` configurations.

__Note:__ Use `~/.gitconfig.local` to store sensitive information such
as the `git` user credentials, e.g.:

```bash
[user]
    name = Cătălin Mariș
    email = alrra@example.com
```

#### `~/.vimrc.local`

If the `~/.vimrc.local` file exists, it will be automatically sourced
after `~/.vimrc`, thus, allowing its content to add or overwrite the
settings from `~/.vimrc`.

#### `~/.gvimrc.local`

Same as `~/.vimrc.local` but for `~/.gvimrc`.

### Forks

If you decide to fork this project, don't forget to substitute my
username with your own in the [setup snippets](#setup) and [in the
`dotfiles` script](https://github.com/alrra/dotfiles/blob/5b524ba9ca07b66db1955d18a2fb66bf4b48f677/dotfiles#L3).


## Update

To update the dotfiles you can either run the [`dotfiles`
script](dotfiles) or, if you want to just update one particular part,
run the appropriate [`os` script](os).


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Mathias Bynens'](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher's](https://github.com/necolas)
  [dotfiles](https://github.com/necolas/dotfiles)


## License

The code is available under the [MIT license](LICENSE.txt).
