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
export EDITOR="vim"
[[ -d ~/.npm-global ]] && PATH=~/.npm-global/bin:$PATH
# proxy.sh
[[ -f ~/.config/functions/functions.sh ]] && source ~/.config/functions/functions.sh
[[ -f ~/.config/install/alias ]] && source ~/.config/install/alias
# golang env
[[ -f ~/.config/install/golang.env ]] && source ~/.config/install/golang.env


if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH="/usr/local/opt/node@10/bin:$PATH"
fi

# dart env
if [[ -d "/usr/lib/dart/bin" ]]; then
    PATH="$PATH:/usr/lib/dart/bin"
fi
# dart language pub env
if [ -d ~/.pub-cache/bin ]; then
  export PUB_BIN="$HOME/.pub-cache/bin"
  export PATH="$PATH:$PUB_BIN"
fi

# swift env
if [[ -d "/usr/share/swift" ]]; then
    PATH="$PATH:/usr/share/swift/usr/bin"
fi
# rust bin
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
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

