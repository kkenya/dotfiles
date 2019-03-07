# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# git
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

# go
export GOPATH=$HOME/go

# prompt
ESC="\[\e["
END="\]"
RES="\[\e[m\]"
OFF="0;"
BOLD="1;"
BLACK="30m"
RED="31m" 
GREEN="32m" 
YELLOW="33m" 
BLUE="34m" 
PURPLE="35m" 
CYAN="36m" 
WHITE="37m" 
# default
# export PS1='[\u@\h \W]\$'
#export PS1='\[\e[35m\]\u\[\e[m\]@\[\e[37m\]\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\]\$'
#export PS1="${ESC}${PURPLE}${END}\u${RES}@${ESC}${WHITE}${END}\h${RES} ${ESC}${BOLD}${BLUE}${END}\W${RES}$(__git_ps1)\$"
export PS1='\[\e[1;35m\]\u\[\e[m\]@\[\e[37m\]\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\]$(__git_ps1)\$'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
