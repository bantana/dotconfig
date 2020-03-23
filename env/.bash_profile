# Language env
export LANG="en_US.UTF-8"
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}
export EDITOR="nvim"

# fix node command path
export PATH="/usr/local/opt/node@10/bin:$PATH"
[[ -d ~/.npm-global ]] && PATH=~/.npm-global/bin:$PATH

# proxy.sh
[[ -f ~/.config/functions/functions.sh ]] && source ~/.config/functions/functions.sh

[[ -f ~/.config/install/alias ]] && source ~/.config/install/alias

[[ -f ~/.config/install/golang.env ]] && source ~/.config/install/golang.env

# git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# if you use bash 4.1+, brew install git bash-completion@2
# if [[ -d $(brew --prefix)/etc/bash_completion.d ]]; then
#   export BASH_COMPLETION_COMPAT_DIR=$(brew --prefix)/etc/bash_completion.d
# fi
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -r "/usr/local/opt/bash-completion@2/share/bash-completion/completions/ssh" ]] && . "/usr/local/opt/bash-completion@2/share/bash-completion/completions/ssh"

if [[ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]]; then
    source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
fi
# autojump
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
# git-flow-avh
# /usr/local/opt/gnu-getopt/etc/bash_completion.d
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# dart language env
if [ -d ~/.pub-cache/bin ]; then
  export PUB_BIN="$HOME/.pub-cache/bin"
  export PATH="$PATH:$PUB_BIN"
fi

# flutter on china
if [ -f ~/flutter/bin/flutter ]; then
    export FLUTTER_ROOT="$HOME/flutter"
    export ENABLE_FLUTTER_DESKTOP=true
    # export PUB_HOSTED_URL=https://pub.flutter-io.cn
    # export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    export PATH="$PATH:$HOME/flutter/bin"
else
    git clone -b beta https://github.com/flutter/flutter.git ~/flutter && source ~/.bash_profile
fi

if [[ -d `/usr/libexec/java_home` ]]; then
 export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# export JAVA=`/usr/libexec/java_home -v 13`
#  export JAVA=`/usr/libexec/java_home -v 12`
#  export JAVA12=`/usr/libexec/java_home -v 12`
# export JAVA8=`/usr/libexec/java_home -v 1.8`
#  export JAVA11=`/usr/libexec/java_home -v 11`
fi

#if [[ -d /usr/local/opt/groovy/libexec ]]; then
#  export GROOVY_HOME=/usr/local/opt/groovy/libexec
#fi

## build fuchsia
if [[ -d ~/fuchsia ]]; then
 export FUCHSIA_DIR=$HOME/fuchsia
fi
# fuchsia compile jiri env
if [[ -d $FUCHSIA_DIR/.jiri_root/bin ]]; then
 PATH=$PATH:$FUCHSIA_DIR/scripts:$FUCHSIA_DIR/.jiri_root/bin
fi

if [[ -f $FUCHSIA_DIR/scripts/fx-env.sh ]]; then
 source $FUCHSIA_DIR/scripts/fx-env.sh
fi

# llvm clangd
if [[ -d /usr/local/opt/llvm/bin ]]; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/llvm/lib"
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
fi

# ruby 2.6.x
# By default, binaries installed by gem will be placed into:
# /usr/local/lib/ruby/gems/2.6.0/bin
if [[ -d /usr/local/opt/ruby/bin ]]; then
  PATH="/usr/local/opt/ruby/bin/:$PATH"

# For compilers to find ruby you may need to set:
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"

# For pkg-config to find ruby you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi
# end ruby


[[ -d ~/bin ]] && PATH=$PATH:~/bin

# rust bin
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi
# Bash (macOS/Homebrew)
# $ rustup completions bash > $(brew --prefix)/etc/bash_completion.d/rustup.bash-completion

export TERM="xterm-256color"

export PATH

export PATH="$HOME/.cargo/bin:$PATH"
[[ -s "$HOME/.xmake/profile" ]] && source "$HOME/.xmake/profile" # load xmake profile
