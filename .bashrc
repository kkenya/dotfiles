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

function peco-history() {
    local COUNT=$(history | wc -l)
    # (( expression )) 'arithmetic expression'
    # $(( expression )) 'arithmetic expression return result'
    #local FIRST=$((-1*(LINE_COUNT-1)))
    local PRE_COUNT=$((LINE_COUNT-1))

    if [[ "$PRE_COUNT" == 0 ]] ; then
        # HISTCMD 'The history number, or index in the history list, of the current command. If HISTCMD is unset, it loses its special properties, even if it is subsequently reset.'
        # remove history 'peco-history'
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
    fi

    local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

    # -n 'string is not null.'
    if [[ -n "$CMD" ]] ; then
        # Replace the last entry, "peco-history", with $CMD
        history -s $CMD

        if type osascript > /dev/null 2>&1 ; then
            # Send UP keystroke to console
            (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
        fi

      # Uncomment below to execute it here directly
      # echo $CMD >&2
      # eval $CMD
  else
      # Remove the last entry, "peco-history"
      history -d $((HISTCMD-1))
  fi
}

#function peco-history() {
#    local tac
#    which gtac &> /dev/null && tac="gtac" || \
#        which tac &> /dev/null && tac="tac" || \
#        tac="tail -r"
#    READLINE_LINE=$(HISTTIMEFORMAT= history | $tac | sed -e 's/^\s*[0-9]\+\s\+//' | awk '!a[$0]++' | peco --query "$READLINE_LINE")
#    READLINE_POINT=${#READLINE_LINE}
#}
bind -x '"\C-r": peco-history'

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

#find /etc/httpd  -type f -print | xargs grep 'VirtualHost'
