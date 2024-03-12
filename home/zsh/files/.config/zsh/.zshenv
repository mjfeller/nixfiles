export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DOWNLOADS_DIR=$HOME/Downloads
export XDG_DOCUMENTS_DIR=$HOME/Documents
export XDG_CODE_DIR=$HOME/Development

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/opt/homebrew/sbin
export PATH=$PATH:$HOME/.local/bin

export EDITOR=vim
export PAGER="less -RF"

export MANWIDTH=80
export LESSHISTFILE=-
export HISTFILE=$XDG_CACHE_HOME/bash_history

# Go config
export GOPATH=$XDG_CODE_DIR/go
export PATH=$GOPATH/bin:$PATH

# Pash config
export PASH_TIMEOUT=off
export PASH_KEYID="AD1123AE40116CBA25464FA10B54905CC58C10EE"
case "$(uname -s)" in
    Linux*)  export PASH_CLIP="xclip -i -selection clipboard" ;;
    Darwin*) export PASH_CLIP="pbcopy"   ;;
esac

# GPG config
# export GNUPGHOME=$XDG_DATA_HOME/gnupg

# Notmuch config
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/default/config

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export NVM_DIR=$XDG_CONFIG_HOME/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

declare -a BEMENU_OPTIONS
BEMENU_OPTIONS=(
    --ignorecase
    --line-height 20
    --border 1
    --fn "'Iosevka Comfy Wide Motion 10'"
    --fb '#000000'
    --cb '#000000'
    --nb '#000000'
    --hb '#000000'
    --ab '#000000'
    --tf '#44bc44'
    --hf '#44bc44'
    --bdr '#FFFFFF'
)
export BEMENU_OPTS="${BEMENU_OPTIONS[@]}"
