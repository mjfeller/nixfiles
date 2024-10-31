# Load in zsh completions if they are available
[ -f "$HOME.kube/completion.zsh.inc" ] && source "$HOME.kube/completion.zsh.inc"

# Commonly used kubectl commands
alias k="kubectl"
alias kd="kubectl describe"
alias kpw="watch kubectl get pods"
alias i="istioctl"
alias ia="istioctl analyze"
alias h="helm"


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

kge() {
    # Grab a list of all active generic environments
    kubectl --context=dev get ns -l sunday-env=generic --show-labels=true
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

helm() {
    # Override the helm command to automatically apply flags based on
    # environment variables.
    command helm \
            $([ -z "$KUBENS" ] || printf "--namespace=$KUBENS") \
            $([ -z "$KUBECTX" ] || printf "--kube-context=$KUBECTX") \
            $@
}

istioctl() {
    # Override the istioctl command to automatically apply flags based on
    # environment variables.
    command istioctl \
            $([ -z "$KUBENS" ] || printf "--namespace=$KUBENS") \
            $([ -z "$KUBECTX" ] || printf "--context=$KUBECTX") \
            $@
}

kube_current_context() {
    # Grab the current kubernetes context based on our environment overrides.
    if [ -n "$KUBECTX" ]; then
        print "$KUBECTX"
    elif [ -d "$HOME/.kube" ]; then
        grep -m1 "current-context" "$HOME/.kube/config" | cut -d' ' -f2 2> /dev/null;
    else
        print ""
    fi
}

kube_prompt() {
    # Kubernetes prompt containing the current namespace and context.
    ctx=$(kube_current_context)
    ns="$KUBENS"
    [ -z "$ctx" ] || echo -n "%F{green}$ctx%f "
    [ -z "$ns" ] || echo -n "%F{blue}$ns%f "
}

setopt transient_rprompt
RPROMPT='$(kube_prompt)'
