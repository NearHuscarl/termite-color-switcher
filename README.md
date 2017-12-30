# Termite color switcher

Colorscheme switcher for [termite](https://github.com/thestinger/termite) terminal

![Animated demonstration](https://i.imgur.com/dfX4gAk.gif)

## Dependency

* `termite`

## Setup

#### Download

If you already have custom path in `$PATH` just copy the source file there
``` bash
$ cd custom/path/in/$PATH
$ git clone https://github.com/NearHuscarl/termite-color-switcher
$ cp termite-color-switcher/bin/color color
```

If you dont have one yet, create a directory and add it to `$PATH` then copy
the source file to the created path. In this example, the custom path will be
`~/bin`
``` bash
$ mkdir ~/bin && cd $_
$ echo 'export PATH=$PATH:$HOME/bin' >> .bashrc # replace .bashrc with .zshrc if you use zsh
$ git clone https://github.com/NearHuscarl/termite-color-switcher
$ cp termite-color-switcher/bin/color color
```

**Optional**: Enable autocompletion for bash and zsh

For bash, source the completion file `completion/bash` on shell startup by adding one line in `~/.bashrc`
``` bash
$ mkdir ~/.bash_completion.d
$ cp termite-color-switcher/completion/bash ~/.bash_completion.d/termite-color-switcher.bash
$ echo 'source ~/.bash_completion.d/termite-color-switcher.bash' >> ~/.bashrc
```

For zsh, copy the completion file to one of the paths in `$fpath`, where the
completion files will be sourced when invoke completion on the command at the
first time

If you already have custom path in `$fpath` just copy the completion file there
``` bash
$ echo $fpath
$ cd custom/path/in/$fpath
$ cp termite-color-switcher/completion/zsh termite-color-switcher.zsh
```

If you dont, add one to `$fpath` first, the rest should be similar as above
``` bash
$ fpath=( ~/.zfunc "${fpath[@]}" )
```

#### Setup config

``` bash
$ cd termite-color-switcher && ./setup.sh
```

This script split the termite config file `~/.config/termite/config` into 2
new files

One is `~/.config/termite/option` which will store all configuration except
color (the `[options]` and `[hints]` section)

Another is `~/.config/termite/color/default` which will store the `[colors]`
section. The file name is the name of the colorscheme. In this case the current
color in your config is the `default` colorscheme

## Usage
``` bash
$ color --help
color <colorscheme>
Commands:
  -h, --help                  print this help message
  -c, --cycle                 cycle through available colorschemes
  -C, --Cycle                 cycle backward
  -e, --edit [<colorscheme>]  edit <colorscheme> file using $EDITOR
                              default is current colorscheme
  -l, --list                  print all available colorschemes
  -r, --reload                reload current colorscheme
  -s, --switch <colorscheme>  switch to <colorscheme>
  <colorscheme>               same as above
```

List all available colorschemes:
``` bash
$ color --list
flat
gotham
solarized
```

Cycle through colorscheme list:
``` bash
$ color --cycle
Switch to colorscheme gotham
$ color --cycle
Switch to colorscheme solarized
$ color --cycle
Switch to colorscheme flat
```

Switch to a specified colorscheme:
``` bash
$ color gotham # or $ color --switch gotham
```

Edit a colorscheme file:
``` bash
$ color --edit solarized
```

Create new colorscheme:

[terminal.sexy](http://terminal.sexy/) is a good site to create new colorscheme
for various terminal (including termite)

## License

[BSD 3-Clause](https://github.com/NearHuscarl/termite-color-switcher/blob/master/LICENSE.md)
