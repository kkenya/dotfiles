# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# default
# export PS1='[\u@\h \W]\$'
export PS1='\[\e[1;32m\]\u\[\e[m\]@\[\e[37m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$(__git_ps1)\$ '

# git
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

# go
export GOPATH=$HOME/go

# 重複舌履歴と空白を含む履歴を保存しない
export HISTCONTROL=ignoreboth # shorthand for 'gnorespace' and 'ignoredups'
export HISTSIZE=2000

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s06540/google-cloud-sdk/path.bash.inc' ]; then . '/Users/s06540/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s06540/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/s06540/google-cloud-sdk/completion.bash.inc'; fi
