# Cătălin’s dotfiles

## Setup

To setup the dotfiles, run the following snippet in the terminal.

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/dotfiles)"` |

The snippet will:

* Download the dotfiles on your computer (by default it will
  suggest `~/projects/dotfiles`)
* Create additional
  [directories](https://github.com/alrra/dotfiles/blob/29bdcbc72260321013d89654283000666052be83/lib/dotfiles.sh#L29-L34)
* Copy/symlink the
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

## Update

To update the dotfiles, run the [`dotfiles`](dotfiles) script.

```bash
$ ./dotfiles
```

If you want to avoid the confirmation prompt, use the `-f` option, but be
careful, it will overwrite everything!

```bash
$ ./dotfiles -f
```

The update process will try to do basically the same things as setup, but
instead of downloading the dotfiles, it will just fetch the latest changes.

## Acknowledgements

* [Mathias Bynens](https://github.com/mathiasbynens) ~
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher](https://github.com/necolas) ~
  [dotfiles](https://github.com/necolas/dotfiles)
