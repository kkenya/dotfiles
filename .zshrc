# zshrcが読みこれまれている場合読み込みをスキップする
if [ -z $ZSH_ENV_LOADED ]; then
  export PATH="${HOME}/local/bin:${PATH}"
  #export $ZSH_ENV_LOADED="1"
else
  print ".zshenv の 読み込みをスキップしました \n"
fi

HISTFILE="${HOME}/.zsh_history"
# メモリに保存される履歴の件数
HISTSIZE=50000
# 履歴ファイルに保存される履歴の件数
SAVEHIST=10000
# 開始と終了を記録
setopt EXTENDED_HISTORY
# 重複した履歴を保存しない
setopt HIST_IGNORE_DUPS
# 履歴を共有する
# setopt share_history

zstyle :compinstall filename "${HOME}/.zshrc"
# 大文字、小文字を無視して保管する
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

fpath+=~/.zfunc

autoload -Uz compinit
compinit

# zshrc.zwcが古い場合にコンパイルする
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi

# zsh-zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# 単語の区切りとみなさない文字を定義する
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# ^uでカーソルから行頭までを削除
# default kill-whole-line
bindkey \^U backward-kill-line
# git completion
[[ -f /usr/local/share/zsh/site-functions ]] && . /usr/local/share/zsh/site-functions
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
[[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]] && . /usr/local/etc/bash_completion.d/git-prompt.sh
# unstaged (*) and staged (+) changes will be shown next to the branch name.
GIT_PS1_SHOWDIRTYSTATE=true
#  If something is stashed, then a '$' will be shown next to the branch name.
#GIT_PS1_SHOWSTASHSTATE=false
#GIT_PS1_SHOWUPSTREAM
#GIT_PS1_DESCRIBE_STYLE
# If there're untracked files, then a '%' will be shown next to the branch name.
#GIT_PS1_SHOWUNTRACKEDFILES=false
# difference between HEAD and its upstream
#GIT_PS1_SHOWUPSTREAM=false
# colored hint about the current dirty state
GIT_PS1_SHOWCOLORHINTS=true
# If you would like __git_ps1 to do nothing in the case when the current directory is set up to be ignored by git
GIT_PS1_HIDE_IF_PWD_IGNORED=false
setopt PROMPT_SUBST
#PS1='[%F{green}%n%f@%m %c$(__git_ps1 " (%s)")]\$ '
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# %n
# %m
# %~
# %#
PS1='%F{green}%n%f@%m[%F{cyan}%~%f]$(__git_ps1) %# '

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# phpbrew
#[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Bash 4+ required
# READLINE_LINE The contents of the Readline line buffer, for use with ‘bind -x’
# READLINE_POINT The position of the insertion point in the Readline line buffer, for use with ‘bind -x’
#function peco-ghq(){
#    local SELECTED=$(ghq list --full-path | peco --query "${READLINE_LINE}")
#    if [[ -n "${SELECTED}" ]]; then
#        READLINE_LINE="cd ${SELECTED}"
#        READLINE_POINT=${#READLINE_LINE}
#        #cd ${selected}
#    fi
#}
#bind -x '"\C-]": peco-ghq'
#
#function peco-history() {
#  local tac_cmd
#  which gtac &> /dev/null && tac_cmd=gtac || tac_cmd=tac
#  BUFFER=$(fc -l -n 1 | eval $tac_cmd | peco --query "${LBUFFER}") 
#  CURSOR=${#BUFFER}
#  zle -R -c               # refresh
#}

function peco-history() {
    local COUNT=$(history | wc -l)
    # (( expression )) 'arithmetic expression'
    # $(( expression )) 'arithmetic expression return result'
    #local FIRST=$((-1*(LINE_COUNT-1)))
    local PRE_COUNT=$((COUNT-1))

    if [[ "$PRE_COUNT" == 0 ]] ; then
        # HISTCMD 'The history number, or index in the history list, of the current command. If HISTCMD is unset, it loses its special properties, even if it is subsequently reset.'
        # remove history 'peco-history'
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
    fi

    local SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[[:blank:]]*[0-9]+[[:blank:]]+//' | sort | uniq | peco --query "${READLINE_LINE}")
    BUFFER=${SELECTED}
    CURSOR=${#BUFFER}
    # refresh
    zle -R -c               
}
zle -N peco-history
bindkey '^r' peco-history

#function peco-history() {
#    local COUNT=$(history | wc -l)
#    # (( expression )) 'arithmetic expression'
#    # $(( expression )) 'arithmetic expression return result'
#    #local FIRST=$((-1*(LINE_COUNT-1)))
#    local PRE_COUNT=$((COUNT-1))
#
#    if [[ "$PRE_COUNT" == 0 ]] ; then
#        # HISTCMD 'The history number, or index in the history list, of the current command. If HISTCMD is unset, it loses its special properties, even if it is subsequently reset.'
#        # remove history 'peco-history'
#        history -d $((HISTCMD-1))
#        echo "No history" >&2
#        return
#    fi
#
#    # fc -l $PRE_COUNT '最近のコマンド$PRE_COUNT個が出力されます'
#    # -k POS1[,POS2] '-K POS1[,POS2] ソートフィールド指定の POSIX 形式。今後はこちらが推奨される。行の POS1 から POS2 までのフィールドを指定する。 POS2 を含む。 POS2 が省略されたら行末まで。 フィールドと文字位置はそれぞれ 0 から数えはじめる。'
#    # sort -k 2 '２番めのフィールドで並び替える "1852	 git s" ならコマンドの入力履歴である "git s"が対償のフィールドになる'
#    # sort -k 2 -k 1 'ソート条件を指定する場合-kを複数書く'
#    # sort -b '各行の比較の際に、行頭の空白を無視する。'
#    # uniq -f 1 '区切り文字で区切られたフィールドの１つ目を無視する'
#    #local SELECTED=$(fc -l -$PRE_COUNT | sort -b -k 2,2 -k 1nr,1 | uniq -f 1 | sed -E 's/^[0-9]+[[:blank:]]+//' | peco --query "${READLINE_LINE}") 
#    #local  SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[0-9]+[[:blank:]]+//' | sort | uniq | peco | head -n 1)
#    local SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[0-9]+[[:blank:]]+//' | sort | uniq | peco --query "${READLINE_LINE}")
#        READLINE_LINE="${SELECTED}"
#        READLINE_POINT=${#READLINE_LINE}
#
#    #local CMD=$(fc -l $PRE_COUNT | sort -b -k 2,2 -k 1nr,1 | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)
#    # -n 'string is not null.'
#    #if [[ -n "$SELECTED" ]] ; then
#    #    # Replace the last entry, "peco-history", with $CMD
#    #    history -s $SELECTED
#
#    #    #if type osascript > /dev/null 2>&1 ; then
#    #    #    # Send UP keystroke to console
#    #    #    (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
#    #    #fi
#
#    #  # Uncomment below to execute it here directly
#    #  # echo $CMD >&2
#    #  # eval $CMD
#    #else
#    #    # Remove the last entry, "peco-history"
#    #    history -d $((HISTCMD-1))
#    #fi
#}
#bind -x '"\C-r": peco-history'

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
alias ll="ls -lah"
alias rm="rm -i"
alias type="type -a"
alias du="du -h"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="~"

# Replacement for 'ls' written in Rust. https://the.exa.website/
alias ls="exa"

# A cat(1) clone with wings. https://github.com/sharkdp/bat
alias cat="bat"

# Ruby on Rails
#alias be="bundle exec"
#alias bi="bundle install --path vendor/bundle"
#alias be="bundle exec"

# start corrent directory in an opened window
alias vs="code -r ."
alias ins="code-insiders -r ."

# find /etc/httpd  -type f -print | xargs grep 'VirtualHost'
# grep -n -3 master
# git d origin/feature/year_2020 --name-only | grep php | xargs git diff origin/feature/year_2020
#
# go
if [[ -d "$HOME/work/go" ]]; then
    export GOPATH="$HOME/work/go"
    export GOROOT="$(brew --prefix golang)/libexec" export PATH="$GOPATH/bin:$PATH"
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

export PATH="/usr/local/sbin:$PATH"

# python version manager
if [[ -d "$HOME/.poetry/bin" ]]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/s06540/.sdkman"
[[ -s "/Users/s06540/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/s06540/.sdkman/bin/sdkman-init.sh"

