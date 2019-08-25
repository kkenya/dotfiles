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
if [ -f '/usr/local/etc/bash_completion.d/git-prompt.sh' ]; then . '/usr/local/etc/bash_completion.d/git-prompt.sh'; fi
if [ -f '/usr/local/etc/bash_completion.d/git-completion.bash' ]; then . '/usr/local/etc/bash_completion.d/git-completion.bash'; fi
GIT_PS1_SHOWDIRTYSTATE=true

# 重複舌履歴と空白を含む履歴を保存しない
export HISTCONTROL=ignoreboth # shorthand for 'gnorespace' and 'ignoredups'
export HISTSIZE=2000

# go
if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
fi

# rbenv
if [ -f "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# composer
if [ -f "$HOME/.composer/vendor/bin" ]; then export PATH="$HOME/.composer/vendor/bin:$PATH"; fi

# google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'; fi
