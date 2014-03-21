# Cătălin’s dotfiles

## Setup

To setup the dotfiles, run the following snippet in the terminal.

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/lib/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/lib/dotfiles)"` |


## Update

To update the dotfiles, run the [`dotfiles`](lib/dotfiles) script.

```bash
$ ./dotfiles
```

If you want to avoid the confirmation prompt, use the `-f` option, but be
careful, it will overwrite everything!

```bash
$ ./dotfiles -f
```


## Acknowledgements

* [Mathias Bynens](https://github.com/mathiasbynens) ~
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher](https://github.com/necolas) ~
  [dotfiles](https://github.com/necolas/dotfiles)
