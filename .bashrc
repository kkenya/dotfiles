# ^wで削除する単語の境界に/を含める
if [[ -t 1 ]]; then
    stty werase undef
    bind '"\C-w":unix-filename-rubout'
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Bash 4+ required
# READLINE_LINE The contents of the Readline line buffer, for use with ‘bind -x’
# READLINE_POINT The position of the insertion point in the Readline line buffer, for use with ‘bind -x’
function peco-ghq(){
    local selected=$(ghq list --full-path | peco --query "${READLINE_LINE}")
    if [ -n "${selected}" ]; then
        READLINE_LINE="cd ${selected}"
        READLINE_POINT=${#READLINE_LINE}
        #cd ${selected}
    fi
}
bind -x '"\C-]": peco-ghq'

# show pid port
# usage port 8080"
port() {
	lsof -i:$1
}

# restart shell
restart() {
    exec -l $SHELL
}

# cd after mkdir
mkcd() {
    mkdir $1 && cd $_
}

findfile() {
    mdfind -onlyin ~ $1
}

# built in
alias ll="ls -la"
alias rm="rm -i"
alias type="type -a"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="~"

# Replacement for 'ls' written in Rust. https://the.exa.website/
alias ls="exa"

# Ruby on Rails
#alias be="bundle exec"
#alias bi="bundle install --path vendor/bundle"
#alias be="bundle exec"

# start corrent directory in an opened window
alias vs="code -r ."
alias ins="code-insiders -r ."

# othier
alias f="mdfind"
alias fn="mdfind --name"
alias md="code-insiders -r ~/Documents/md"

