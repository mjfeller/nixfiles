set -o emacs

# my config files
source $ZDOTDIR/aliasrc
source $ZDOTDIR/fzf.zsh
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
			sudo -E nix run nix-darwin -- switch --flake "${nixfiles}#${name%%.*}"
			;;
		*)
			echo "Could not detect OS"
			exit 1
			;;
	esac
}

vterm_printf() {
	if [ -n "$TMUX" ] \
		   && { [ "${TERM%%-*}" = "tmux" ] \
				|| [ "${TERM%%-*}" = "screen" ]; }; then
		# Tell tmux to pass the escape sequences through
		printf "\ePtmux;\e\e]%s\007\e\\" "$1"
	elif [ "${TERM%%-*}" = "screen" ]; then
		# GNU screen (screen, screen-256color, screen-256color-bce)
		printf "\eP\e]%s\007\e\\" "$1"
	else
		printf "\e]%s\e\\" "$1"
	fi
}

vterm_less() {
	printf "\e]51;Eless \""
	cat | base64 -w0
	printf "\"\e\\"
}
alias less="vterm_less"

vterm_prompt_end() {
	vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}

setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
