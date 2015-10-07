
######################################################
# PREFIXes and SUBHOMES
#####################################################

export LOCAL=~/local
[ ! -d $LOCAL ] && mkdir -p $LOCAL

export LBIN=~/local/bin
[ ! -d $LBIN ] && mkdir -p $LBIN



######################################################
# ALIAS
#####################################################

alias lh='ls -lh'
alias ll='lh'
alias la='lh -Ah'
alias l='lh -CF'


# always ask for confirmation
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'


# grep abreviations
alias grep='grep --color=auto'
alias ag="grep -iR"
alias eag="egrep -Ri --color=auto"
alias fag="fgrep -Ri --color=auto"

# now
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# yum shortcuts
alias yiy="yum install -y"
alias ys="yum search"

# Emacs on terminal
alias enw="emacs -nw"

# TODO list
alias t="todo.sh -d $LOCAL/TODO/cfg/todo.cfg"


######################################################
# PATHS: BIN and LD
#####################################################


# JAVA Setup
export JAVA_HOME=/opt/java/default
export PATH=$PATH:$JAVA_HOME/bin

# CUDA Setup
export CUDA_HOME=/usr/local/cuda

export PS1="[\u@\h \W]\$ "

export PATH=$PATH:$LBIN:$CUDA_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LOCAL/lib:$LOCAL/lib64:$CUDA_HOME/lib:$CUDA_HOME/lib64



######################################################
# AUTOCOMPLETE
#####################################################
# SSH

#autocomlpete with .ssh/known_hosts
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | \
    sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh scp sftp

#autocomplete using .ssh/config
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

#complete -W "sh/config  | grep -w Host |  cut -d' ' -f2" ssh

# TODO.txt
source ~/TODO/cfg/todo_completion
complete -F _todo t




