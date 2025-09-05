# Load in zsh completions if they are available
[ -f "$HOME/.kube/completion.zsh.inc" ] && source "$HOME/.kube/completion.zsh.inc"

# Commonly used kubectl commands
alias k="kubectl"
alias kd="kubectl describe"


kcc() {
	# Switch current kube context to $1 if provided or prompt caller to
	# select from the available contexts in the current kube config.
	ctx=$([ -z "$1" ] && kubectl config get-contexts -o name | fzf || printf "$1")
	[ -z "$ctx" ] || kubectl config use-context $ctx
}

kc() {
	# Automatically apply the --context=$1 to each kubectl command. When
	# no $1 is passed the env var is unset.
	ctx=$([ -z "$1" ] && kubectl config get-contexts -o name | fzf || printf "$1")
	[ -z "$ctx" ] && unset KUBECTX || export KUBECTX="$ctx"
}

kn() {
	# Automatically apply the --namespace=$1 to each kubectl
	# command. When no $1 is passed the env var is unset.
	[ -z "$1" ] && unset KUBENS || export KUBENS=$1
}

knn() {
	ns=$(kubectl get namespaces -o name | sed 's/^namespace\///' | fzf)
	[ -z "$ns" ] || kn $ns
}

kw() {
	# Override the kubectl command to automatically apply flags based on
	# environment variables.
	command watch kubectl \
		$([ -z "$KUBENS" ] || printf "--namespace=$KUBENS") \
		$([ -z "$KUBECTX" ] || printf "--context=$KUBECTX") \
		$@
}

kubectl() {
	# Override the kubectl command to automatically apply flags based on
	# environment variables.
	command kubectl \
		$([ -z "$KUBENS" ] || printf "--namespace=$KUBENS") \
		$([ -z "$KUBECTX" ] || printf "--context=$KUBECTX") \
		$@
}
