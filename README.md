[Cătălin](https://github.com/alrra)’s dotfiles
==============================================

[![Build Status](https://github.com/alrra/dotfiles/workflows/test/badge.svg)](https://github.com/alrra/dotfiles/actions)

These are the base dotfiles that I start with when I set up a
new environment. For more specific local needs I use the `.local`
files described in the [`Local Settings`](#local-settings) section.

Table of Contents
-----------------

* [🔧 Setup](#setup)
* [💄 Customize](#customize)
  * [🔀 Forks](#forks)
  * [🌐 Local Settings](#local-settings)
    * [🐚 `~/.bash.local`](#bashlocal)
    * [🔁 `~/.gitconfig.local`](#gitconfiglocal)
    * [⌨️  `~/.vimrc.local`](#vimrclocal)
* [↕️  Update](#update)
* [📸 Screenshots](#screenshots)
  * [🔁 `Git`](#git)
  * [⌨️  `tmux` & `Vim`](#tmux--vim)
* [📄 License](#license)

Setup
-----

To set up the `dotfiles` just run the appropriate snippet in the
terminal:

(⚠️  **DO NOT** run the `setup` snippet if you do not fully
understand [what it does][setup]. Seriously, **DON'T**!)

| OS | Snippet |
|:---|:---|
| `macOS` | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/src/os/setup.sh)"` |
| `Ubuntu` | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/src/os/setup.sh)"` |

That's it! :sparkles:

The setup process will:

* Download the dotfiles on your computer (by default it will
  suggest `~/projects/dotfiles`)
* Create some additional [directories][directories]
* [Symlink][symlink] the
  [`git`](src/git),
  [`shell`](src/shell), and
  [`vim`](src/vim) files
* Install applications / command-line tools for
  [`macOS`](src/os/install/macos) /
  [`Ubuntu`](src/os/install/ubuntu)
* Set custom
  [`macOS`](src/os/preferences/macos) /
  [`Ubuntu`](src/os/preferences/ubuntu) preferences
* Install [`vim` plugins](src/vim/vim/plugins)

Setup process in action:

| ![Setup process on macOS](https://cloud.githubusercontent.com/assets/1223565/19314446/cd89a592-90a2-11e6-948d-9d75247088ba.gif) | ![Setup process on Ubuntu](https://cloud.githubusercontent.com/assets/1223565/19048636/e23e347a-89af-11e6-853c-98616b75b6ae.gif) |
|:---:|:---:|
| `macOS` | `Ubuntu` |

Customize
---------

### Local Settings

The `dotfiles` can be easily extended to suit additional local
requirements by using the following files:

#### `~/.bash.local`

The `~/.bash.local` file it will be automatically sourced after
all the other [`bash` related files][shell], thus, allowing
its content to add to or overwrite the existing aliases, settings,
PATH, etc.

Here is a very simple example of a `~/.bash.local` file:

```bash
#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set local aliases.

alias starwars="telnet towel.blinkenlights.nl"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set PATH additions.

PATH="$PATH:$HOME/projects/dotfiles/src/bin"

export PATH

```

#### `~/.gitconfig.local`

The `~/.gitconfig.local` file it will be automatically included
after the configurations from `~/.gitconfig`, thus, allowing its
content to overwrite or add to the existing `Git` configurations.

__Note:__ Use `~/.gitconfig.local` to store sensitive information
such as the `Git` user credentials, e.g.:

```bash
[commit]

    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/

    gpgsign = true

[user]

    name = Cătălin Mariș
    email = alrra@example.com
    signingkey = XXXXXXXX
```

#### `~/.vimrc.local`

The `~/.vimrc.local` file it will be automatically sourced after
`~/.vimrc`, thus, allowing its content to add or overwrite the
settings from `~/.vimrc`.

### Forks

If you decide to fork this project, do not forget to substitute
my username with your own in the [`setup` snippets](#setup) and
[in the `setup` script][setup line]

Update
------

To update the dotfiles you can either run the [`setup` script][setup]
or, if you want to just update one particular part, run the appropriate
[`os` script](src/os).

Screenshots
-----------

### Git

Output for `Git status`:

| ![Output for Git status on macOS](https://cloud.githubusercontent.com/assets/1223565/10561038/f9f11a28-7525-11e5-8e1d-a304ad3557f9.png) | ![Output for Git status on Ubuntu](https://cloud.githubusercontent.com/assets/1223565/8397636/3708d218-1ddb-11e5-9d40-21c6871271b9.png) |
|:---:|:---:|
| `macOS` | `Ubuntu` |

Output for `Git log`:

| ![Output for Git status on macOS](https://cloud.githubusercontent.com/assets/1223565/10560966/e4ec08a6-7523-11e5-8941-4e12f6550a63.png) | ![Output for Git log on Ubuntu](https://cloud.githubusercontent.com/assets/1223565/10560955/4b5e1300-7523-11e5-9e96-95ea67de9474.png) |
|:---:|:---:|
| `macOS` | `Ubuntu` |

### tmux & Vim

| ![tmux and Vim on macOS](https://cloud.githubusercontent.com/assets/1223565/10561007/498e1212-7525-11e5-8252-81503b3d6184.png) |
![tmux and Vim on Ubuntu](https://cloud.githubusercontent.com/assets/1223565/10560956/557ca2de-7523-11e5-9000-fc1e189a95f5.png) |
|:---:|:---:|
| `macOS` | `Ubuntu` |

License
-------

The code is available under the [MIT license][license].

<!-- Link labels: -->

[directories]: src/os/create_directories.sh
[dotfiles mathias]: https://github.com/mathiasbynens/dotfiles
[github mathias ]: https://github.com/mathiasbynens
[license]: LICENSE.txt
[setup line]: https://github.com/alrra/dotfiles/blob/1503cf23ef23f6e31342b140bcd246625160b94f/src/os/setup.sh#L3
[setup]: src/os/setup.sh
[shell]: src/shell
[symlink]: src/os/create_symbolic_links.sh
