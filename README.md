# Cătălin’s dotfiles

## Setup

To setup the dotfiles, run the following snippet in the terminal.

| OS | Snippet |
|:---:|:---|
| OS X | `bash -c "$(curl -LsS https://raw.github.com/alrra/dotfiles/master/lib/dotfiles)"` |
| Ubuntu | `bash -c "$(wget -qO - https://raw.github.com/alrra/dotfiles/master/lib/dotfiles)"` |

The snippet will:

* Download the dotfiles on your computer (by default it will suggest `~/projects/dotfiles`)
* Create additional [directories](https://github.com/alrra/dotfiles/blob/29bdcbc72260321013d89654283000666052be83/lib/dotfiles.sh#L29-L34)
* Copy/symlink the [git](git), [shell](shell), and [vim](vim) files
* Set custom [OS X](lib/osx/set_preferences.sh) / [Ubuntu](lib/ubuntu/set_preferences.sh) preferences
* Install [vim plugins](vim/vim/plugins)
* Install applications / command-line tools:

  | Application / CLT | OS X | Ubuntu |
|:---|:---:|:---:|
| [Android File Transfer](http://www.android.com/filetransfer/) | ✔ | — |
| [Atom](https://atom.io/) | ✔ | ✔ |
| `build-essential` | — | ✔ |
| [Chrome](https://www.google.com/chrome) | ✔ | ✖ |
| [Chrome Canary](https://www.google.com/intl/en/chrome/browser/canary.html) | ✔ | — |
| [Chrome Dev](http://www.chromium.org/getting-involved/dev-channel) | ✖ |  ✔ |
| [Chromium](http://www.chromium.org/) | ✔ | ✔ |
| [cURL](http://curl.haxx.se/) | ― | ✔ |
| `debian-archive-keyring` | ― | ✔ |
| [Dropbox](https://www.dropbox.com/) | ✔ | ✔ |
| [Firefox](http://www.mozilla.org/firefox/) | ✔ | ✔ |
| [Firefox Nightly](http://nightly.mozilla.org/) | ✔ | ✔ |
| [Flash](http://get.adobe.com/flashplayer/) | ✔ | ✔ |
| [Gimp](http://www.gimp.org/) | ✔ | ✔ |
| [Git](http://git-scm.com/) | ✔ | ✔ |
| [Homebrew](http://brew.sh/) | ✔ | ― |
| [Homebrew Alternate Casks](https://github.com/caskroom/homebrew-versions) | ✔ | ― |
| [Homebrew Casks](http://caskroom.io/) | ✔ | ― |
| [ImageMagick](http://www.imagemagick.org/) | ✔ | ✔ |
| [ImageOptim](http://imageoptim.com/) | ✔ | ― |
| [Libre Office](https://www.libreoffice.org/) | ✔ | ― |
| [LICEcap](http://www.cockos.com/licecap/) | ✔ | ― |
| [MacVim](https://code.google.com/p/macvim/) | ✔ | ― |
| [Node.js](http://nodejs.org/) + [npm](https://www.npmjs.org/) | ✔ | ✔ |
| [Opera](http://www.opera.com/) | ✔ | ✔ |
| [Opera Developer](http://www.opera.com/developer) | ✔ | ― |
| [Opera Next](http://www.opera.com/next) | ✔ | ✔ |
| [Transmission](http://www.transmissionbt.com/) | ✔ | ✔ |
| vim-gnome | ― | ✔ |
| [Virtualbox](https://www.virtualbox.org/) | ✔ | ✔ |
| [VLC](http://www.videolan.org/vlc/index.html) | ✔ | ✔ |
| [The Unarchiver](http://wakaba.c3.cx/s/apps/unarchiver) | ✔ | ― |
| [Webkit Nightly](http://nightly.webkit.org/) | ✔ | ― |
| [xclip](http://sourceforge.net/projects/xclip/) | ― | ✔ |
| [Zopfli](http://code.google.com/p/zopfli/) | ✔ | ✔ |

  `―` indicates that the application / CLT is already installed, or does not
      exist for that OS


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

The update process will try to do basically the same things as setup, but
instead of downloading the dotfiles, it will just fetch the latest changes.

## Acknowledgements

* [Mathias Bynens](https://github.com/mathiasbynens) ~
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher](https://github.com/necolas) ~
  [dotfiles](https://github.com/necolas/dotfiles)
