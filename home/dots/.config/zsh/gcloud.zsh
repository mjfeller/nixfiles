# Important shit to remember
#    gcloud auth login
#    gcloud auth applicaiton-default login

# Commonly used gcloud commands
alias g="gcloud"


gac() {
    # Switch between google cloud configurations.
    cfg=$(gcloud config configurations list | awk 'NR!=-1 { print $1 }' | fzf -e)
    [ -z "$cfg" ] || gcloud config configurations activate $cfg
}

gssh() {
    # List out compute instances and ssh into a selected virtual
    # machine.
    instance=$(gcloud compute instances list | awk '/^gke/ { print $1 }' | sort | fzf)
    [ -z "$instance" ] || gcloud compute ssh $instance
}

gsp() {
    # Switch which google cloud project is currently configured.
    project=$(gcloud projects list | awk 'NR!=1 { print $1 }' | sort | fzf)
    [ -z "$project" ] || gcloud config set project $project
}
