<img src="https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/logo.png" alt="rainbow_levels.vim" align="right" width="150px"/>

# Rainbow Levels

A different approach to code highlighting.

[![CI][ci_badge]][ci]
[![Code Coverage][codecov_badge]][codecov]
[![Version][version_badge]][vim_org]
[![Docs][docs_badge]][docs]

This plugin highlights code by indentation level instead of language syntax.
<br/>
It is specially useful when dealing with deeply nested code or callback hells.

## Screenshot

![Rainbow Levels Screenshot][]

## Usage

This plugin exposes three self-explanatory commands:

* `:RainbowLevelsOn`
* `:RainbowLevelsOff`
* `:RainbowLevelsToggle`

And you can use them in a variety of ways, for example:

```vim
" Creating a mapping to turn it on and off:
map <leader>l :RainbowLevelsToggle<cr>

" Or automatically turning it on for certain file types:
autocmd Filetype * if index(['javascript', 'python', 'php', 'xml', 'yaml'], &ft) | call rainbow_levels#on() | else | call rainbow_levels#off() | endif
```

## Customization

To customize the levels you just need to define highlight groups whith the
name `RainbowLevelsN`, where `N` is the number of the level.

By default this plugin defines `7` highlight groups, simply linking to common
existing highlight groups, in order to respect your colorscheme.

But you are free to define as many levels you wish. Check the examples below
and also the [User-Contributed Themes][user_themes] page for inspiration.

### Examples

#### Jellybeans Rainbow

<img align="right" width="45%" title="Jellybeans Rainbow" src="https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/example-jellybeans.png"/>

Using groups defined by [Jellybeans][] colorscheme in a "rainbow" sequence.

```vim
hi! link RainbowLevel0 Constant
hi! link RainbowLevel1 Type
hi! link RainbowLevel2 Function
hi! link RainbowLevel3 String
hi! link RainbowLevel4 PreProc
hi! link RainbowLevel5 Statement
hi! link RainbowLevel6 Identifier
hi! link RainbowLevel7 Normal
hi! link RainbowLevel8 Comment
```

<br/>

#### Background Only

<img align="right" width="45%" title="Background Only" src="https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/example-background.png"/>

Want to keep syntax highlight? No problem! You can change only the background
colors instead.

```vim
hi! RainbowLevel0 ctermbg=240 guibg=#585858
hi! RainbowLevel1 ctermbg=239 guibg=#4e4e4e
hi! RainbowLevel2 ctermbg=238 guibg=#444444
hi! RainbowLevel3 ctermbg=237 guibg=#3a3a3a
hi! RainbowLevel4 ctermbg=236 guibg=#303030
hi! RainbowLevel5 ctermbg=235 guibg=#262626
hi! RainbowLevel6 ctermbg=234 guibg=#1c1c1c
hi! RainbowLevel7 ctermbg=233 guibg=#121212
hi! RainbowLevel8 ctermbg=232 guibg=#080808
```

<br/>

#### Cycle colors

<img align="right" width="45%" title="Cycle colors" src="https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/example-cycle.png"/>

Using a loop to automate the tedious work of defining all highlight groups.

```vim
for level in range(0, 10, 2)
  exe 'hi! RainbowLevel'.level.' guifg=magenta'
  exe 'hi! RainbowLevel'.(level+1).' guifg=cyan'
endfor
```

<br/><br/><br/><br/>

#### Level Alert

<img align="right" width="45%" title="Level Alert" src="https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/example-alert.png"/>

Nothing shows up until a certain threshold, warning you that the code is going
too deep.

```vim
hi! RainbowLevel0 guibg=none guifg=none
hi! RainbowLevel2 guibg=none guifg=none
hi! RainbowLevel3 guibg=none guifg=none
hi! RainbowLevel4 guibg=none guifg=none
hi! link RainbowLevel5 WarningMsg
for level in range(6, 10)
  exe 'hi! link RainbowLevel'.level.' ErrorMsg'
endfor
```

<br/>

## Special Thanks

* [Campbell Vertesi][ohthehugemanatee] and [Victor Schroder][schrodervictor]
  for the idea to fade the levels in shades of a single color.

* [David De Sousa][dedsm] and [Lucas Caton][lucascaton] for the idea of
  highlighting only the background color, to keep syntax highlight.

* [Derek Shoemaker][shoemakerdr] for creating the very first
  [User-Contributed Theme][user_themes], with a different "rainbow" order,
  making a beautiful contrast between levels.

* [Ingo Karkat][inkarkat] for identifying and **fixing** several issues
  present on the initial implementation.

## Bugs

Please report any bugs you may find on the GitHub issue tracker:
<http://github.com/thiagoalessio/rainbow_levels.vim/issues>

## License

rainbow_levels.vim is released under the [MIT License][].


<h2></h2><p align="center"><sub>Made with <sub><a href="#"><img src="https://thiagoalessio.github.io/rainbow_levels.vim/readme-images/heart.svg" alt="love" width="14px"/></a></sub> in Berlin</sub></p>

[ci_badge]: https://github.com/thiagoalessio/rainbow_levels.vim/workflows/Tests/badge.svg?event=push
[ci]: https://github.com/thiagoalessio/rainbow_levels.vim/actions?query=workflow%3ATests
[codecov_badge]: https://codecov.io/gh/thiagoalessio/rainbow_levels.vim/branch/main/graph/badge.svg
[codecov]: https://codecov.io/gh/thiagoalessio/rainbow_levels.vim
[version_badge]: https://img.shields.io/badge/version-0.8.0-FF00CC.svg
[docs_badge]: https://img.shields.io/badge/docs-%3Ah%20RainbowLevels-blue.svg
[docs]: https://github.com/thiagoalessio/rainbow_levels.vim/blob/main/doc/rainbow_levels.txt
[vim_org]: http://www.vim.org/scripts/script.php?script_id=5629
[Rainbow Levels Screenshot]: https://raw.githubusercontent.com/thiagoalessio/rainbow_levels.vim/gh-pages/readme-images/screenshot.png
[Jellybeans]: https://github.com/nanotech/jellybeans.vim
[user_themes]: https://github.com/thiagoalessio/rainbow_levels.vim/wiki/User-Contributed-Themes
[ohthehugemanatee]: https://github.com/ohthehugemanatee
[schrodervictor]: https://github.com/schrodervictor
[dedsm]: https://github.com/dedsm
[lucascaton]: https://www.lucascaton.com.br
[shoemakerdr]: https://github.com/shoemakerdr
[inkarkat]: https://github.com/inkarkat
[MIT License]: https://github.com/thiagoalessio/rainbow_levels.vim/blob/main/MIT-LICENSE
