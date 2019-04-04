# Set other ls aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -alF'
alias lh='ls -sh'
alias la='ls -A'
alias l='ls -CF'

# Colourize grep output.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Colourize diff
command -v colordiff >/dev/null 2>&1 && { alias diff=colordiff; }

# Graphical vim
if type vimx >/dev/null 2>&1; then 
    alias vim='vimx'
    export GIT_EDITOR="vimx"
elif type mvim >/dev/null 2>&1; then 
    alias vim='mvim -v'
    export GIT_EDITOR="mvim -v"
fi

# Git fast-forward merge
alias gff='git merge --ff-only'

# hub command for better GitHub integration.
# [ $(which hub 2>/dev/null) ] && alias git=hub

# Force password authentication with SSH. Used to get around the situation
# where SSH freezes while trying to do public key authentication because
# DIRO has the NFS/Kerberos Setup From Hell.
# From http://unix.stackexchange.com/q/15138
alias sshpw='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# Force 256 colors tmux
alias tmux="TERM=xterm-256color tmux"
#alias tmux="tmux -2"  # Force tmux to use 256 colors
. $HOME/.tmux/set_tmux_config.sh

# Autocomplete ssh names in bash (defined in .ssh/config)
_complete_ssh_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                    cut -f 1 -d ' ' | \
                    sed -e s/,.*//g | \
                    grep -v ^# | \
                    uniq | \
                    grep -v "\[" ;
            cat ~/.ssh/config | \
                    grep "^Host " | \
                    awk '{print $2}'
            `
    COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
    return 0
}
complete -F _complete_ssh_hosts ssh


# disk usage
disk_usage() {
    # TODO: apparently ncdu is better
    du -h $1 2> >(grep -v '^du: cannot \(access\|read\)' >&2) | grep '[0-9\.]\+G' | sort -rn
}

# who is using gpus
gpu_who() {
    for i in `nvidia-smi -q -d PIDS | grep ID | cut -d ":" -f2`; do ps -u -p "$i"; done
}

# rsync options
alias rsyncopt="rsync -a -X --partial -h --progress --bwlimit=20000 --copy-links "
alias rsyncopt_nolimit="rsync -a -X --partial -h --progress --copy-links "
cpdataset() {
    if [ "$#" -ne 4 ]; then
        echo "Usage: cpdataset <source_files> <dest_user> <dest_server> <dest_root_dir>"
    else
        tar czf - $1 | ssh $2@$3 "cd $4 && tar xvzf -"
    fi
    }
export -f cpdataset

# Manage the weird pkscreen routine for lisa lab
alias frascreen="pkscreen; sleep 5; screen -r; sleep 2"

# Quick set GPU FLAGS

CVD_CLR(){ export CUDA_VISIBLE_DEVICES=''; }
CVD0(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}0; }
CVD1(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}1; }
CVD2(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}2; }
CVD3(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}3; }
CVD4(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}4; }
CVD5(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}5; }
CVD6(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}6; }
CVD7(){ export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:+${CUDA_VISIBLE_DEVICES},}7; }
CVDNONE(){ export CUDA_VISIBLE_DEVICES=-1; }

# Displays
D0(){ export DISPLAY=localhost:0.0; }
D10(){ export DISPLAY=localhost:10.0; }
D11(){ export DISPLAY=localhost:11.0; }
D12(){ export DISPLAY=localhost:12.0; }

# Frameworks update
# ==================
GITUSER='luca-morreale'

# conda: we don't want to mess with system-wide conda
upconda() {
    $HOME/.miniconda/bin/conda update conda
}

# ENVIRONMENTS
# =============
GDL() {
    conda activate gdlenv
}

CLR() {
    if [ ! -z $CONDA_DEFAULT_ENV ]; then
        conda deactivate 
    fi
}

export -f CLR
export -f GDL


alias tor-browser='/home/luca/tor-browser/Browser/start-tor-browser'
alias searchtext='grep -rnw . -e'
alias gitadddel='git rm $(git ls-files --deleted)'

alias ldu='du -h --max-depth=1 . 2> /dev/null | sort -n -r | less'
