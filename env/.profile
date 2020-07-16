# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# private setting

set -o vi

# Language env
export LANG="en_US.UTF-8"
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}
export VISUAL="nvim";
export EDITOR="nvim"
export proxy="http://127.0.0.1:2000"

if [ -d ~/.npm-global ]; then 
    PATH=~/.npm-global/bin:$PATH
fi
# proxy.sh
if [ -f ~/.config/functions/functions.sh ]; then
    source ~/.config/functions/functions.sh
fi

if [ -f ~/.config/functions/functions.sh ]; then
    source ~/.config/functions/functions.sh
fi
if [ -f ~/.config/install/alias ]; then
    source ~/.config/install/alias
fi

# golang env
if [ -f ~/.config/install/golang.env ]; then
    source ~/.config/install/golang.env
fi
if [ "$(uname -s)" == "Darwin" ]; then
    PATH="/usr/local/opt/node@12/bin:$PATH"
fi
# dart env
if [ -d "/usr/lib/dart/bin" ]; then
    PATH="$PATH:/usr/lib/dart/bin"
fi
# dart language pub env
if [ -d ~/.pub-cache/bin ]; then
  export PUB_BIN="$HOME/.pub-cache/bin"
  export PATH="$PATH:$PUB_BIN"
fi

# # flutter on china
# if [ -f ~/flutter/bin/flutter ]; then
#     export FLUTTER_ROOT="$HOME/flutter"
#     export ENABLE_FLUTTER_DESKTOP=true
#     # export PUB_HOSTED_URL=https://pub.flutter-io.cn
#     # export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
#     export PATH="$PATH:$HOME/flutter/bin"
# # else
# #     git clone -b beta https://github.com/flutter/flutter.git ~/flutter && source ~/.bash_profile
# fi

# swift env
if [ -d "/usr/share/swift" ]; then
    PATH="$PATH:/usr/share/swift/usr/bin"
fi
# rust bin
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.config/bin" ] ; then
    PATH="$HOME/.config/bin:$PATH"
fi

if [ -d ~/bin ]; then 
    PATH=$PATH:~/bin
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# cheat
export CHEAT_CONFIG_PATH="$HOME/.config/cheat/conf.yml"

if [ -f /usr/share/autojump/autojump.bash ]; then
    . /usr/share/autojump/autojump.bash
fi

if [ -d "$HOME/cling/bin" ] ; then
    PATH="$PATH:$HOME/cling/bin"
fi

# fd-find
# cargo install fd-find  or sudo apt install fd-find

if [ -f ~/.fzf/bin/fzf ] && [ -f ~/.cargo/bin/fd ]; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git -E node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Deno was installed successfully to /home/bantana/.deno/bin/deno
# Manually add the directory to your $HOME/.bash_profile (or similar)
if [ -d "$HOME/.deno/bin" ]; then
  export DENO_INSTALL="/home/bantana/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
# Run '/home/bantana/.deno/bin/deno --help' to get started
fi

# haskell cabal
if [ -d "$HOME/.cabal/bin" ]; then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

export GPG_TTY=$(tty)

