# Get the aliases and functions
#if [ -f ~/.bashrc ]; then
#    . ~/.bashrc
#fi

# git completion
[[ -f /usr/local/share/zsh/site-functions ]] && . /usr/local/share/zsh/site-functions
[[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]] && . /usr/local/etc/bash_completion.d/git-prompt.sh


# default
# export PS1='[\u@\h \W]\$'
# export PS1='\[\e[1;32m\]\u\[\e[m\]@\[\e[37m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$(__git_ps1)\$ '
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# 重複した履歴と空白を含む履歴を保存しない
export HISTCONTROL=ignoreboth # shorthand for 'gnorespace' and 'ignoredups'
export HISTSIZE=2000

# git
#if [ -f '/usr/local/etc/bash_completion.d/git-prompt.sh' ]; then . '/usr/local/etc/bash_completion.d/git-prompt.sh'; fi
#if [ -f '/usr/local/etc/bash_completion.d/git-completion.bash' ]; then . '/usr/local/etc/bash_completion.d/git-completion.bash'; fi
#GIT_PS1_SHOWDIRTYSTATE=true

# go
if [[ -d "$HOME/work/go" ]]; then
    export GOPATH="$HOME/work/go"
    export GOROOT="$(brew --prefix golang)/libexec"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="$GOROOT/bin:$PATH"
fi

# rbenv
if [[ -d "$HOME/.rbenv/bin" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# composer
if [[ -d "$HOME/.composer/vendor/bin" ]]; then export PATH="$HOME/.composer/vendor/bin:$PATH"; fi

# google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
#if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# mysql5.7
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# aws cli
export PATH=~/.local/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/s06540/.sdkman"
[[ -s "/Users/s06540/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/s06540/.sdkman/bin/sdkman-init.sh"
