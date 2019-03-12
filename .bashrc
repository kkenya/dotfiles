# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# To enable PHP version info in your shell prompt, please set PHPBREW_SET_PROMPT=1
export PHPBREW_SET_PROMPT=1
# To enable .phpbrewrc file searching, please export the following variable:
export PHPBREW_RC_ENABLE=1

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ^wで削除する単語の境界に/を含める
if [[ -t 1 ]]; then
    stty werase undef
    bind '"\C-w":unix-filename-rubout'
fi

# show pid port 
# usage show-port 8080"
show-port() {
	echo "lsof -i -P | grep $1"
}

# restart shell
restart() {
	exec "$SHELL"
}

# Ruby on Rails
alias be="bundle exec"

# Replacement for 'ls' written in Rust. https://the.exa.website/
alias ls="exa"

# rails
alias bi="bundle install --path vendor/bundle"
alias be="bundle exec"

alias ll="ls -la"
alias rm="rm -i"

# start corrent directory in an opened window
alias code="code -r"

