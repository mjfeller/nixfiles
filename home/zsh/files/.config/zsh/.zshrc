set -o emacs

# my config files
source $ZDOTDIR/aliasrc
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/gcloud.zsh
source $ZDOTDIR/kubernetes.zsh

# setup prompt
setopt prompt_subst
RPROMPT=""
PROMPT="%F{241}#%b%f "

# history in cache directory
SAVEHIST=10000
HISTSIZE=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history
SHELL_SESSION_HISTORY=0

update() {
    nixfiles="${HOME}/.config/nixfiles"
    name="$(hostname)"
    case "$(uname -s)" in
        Linux*)
            sudo nixos-rebuild switch --flake "${nixfiles}"
            ;;
        Darwin*)
            darwin-rebuild switch --flake "${nixfiles}#${name%%.*}"
            ;;
        *)
            echo "Could not detect OS"
            exit 1
            ;;
    esac
}
