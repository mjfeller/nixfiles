# A collection of useful fzf wrapper functions

# visual config
export FZF_DEFAULT_OPTS='--height 40% --exact'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS='--sort --exact'

# repeat history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) \
			    | fzf +s --tac \
			    | sed 's/ *[0-9]* *//')
}

# copy history
fhc() {
	echo -n $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) \
			   | fzf +s --tac | sed 's/ *[0-9]* *//') \
		| pbcopy
}

# kill a process
fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}

if [ -n "${commands[fzf-share]}" ]; then
	source "$(fzf-share)/key-bindings.zsh"
	source "$(fzf-share)/completion.zsh"
fi
