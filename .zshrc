# zshrcが読みこれまれている場合読み込みをスキップする
if [ -z $ZSH_ENV_LOADED ]; then
  export PATH="${HOME}/local/bin:${PATH}"
  #export $ZSH_ENV_LOADED="1"
else
  print "skipped to read .zshenv\n"
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

# 単語の区切りとみなさない文字を定義する
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# ^uでカーソルから行頭までを削除
# default kill-whole-line
bindkey \^U backward-kill-line
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
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
PS1='%F{green}%n%f@%m[%F{cyan}%~%f]$(__git_ps1) %# '

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
#    local SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[[:blank:]]*[0-9]+[[:blank:]]+//' | sort | uniq | peco --query "${READLINE_LINE}")
#    BUFFER=${SELECTED}
#    CURSOR=${#BUFFER}
#    # refresh
#    zle -R -c               
#}
#zle -N peco-history
#bindkey '^r' peco-history

# alias ------------------------------------------------------------------------------------------------------------------------------------
# a 隠しファイル
# h, --header       add a header row to each column
alias ll="ls -lah"
alias rm="rm -i"
alias type="type -a"
alias du="du -h"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
#alias killport="kill $(lsof -t -i:)"

# Replacement for 'ls' written in Rust. https://the.exa.website/
alias ls="exa"

# start corrent directory in an opened window
alias vs="code -r ."
alias vsi="code-insiders -r ."

# find /etc/httpd  -type f -print | xargs grep 'VirtualHost'
# grep -n -3 master

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

# completion ------------------------------------------------------------------------------------------------------------------------------------
# npm complete
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# nvm(node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# composer(php package manager)
if [[ -d "$HOME/.composer/vendor/bin" ]]; then export PATH="$HOME/.composer/vendor/bin:$PATH"; fi
export PATH="/usr/local/sbin:$PATH"

# pyenv(python version manager)
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

# jdkman(java sdk version manager)
export SDKMAN_DIR="/Users/s06540/.sdkman"
[[ -s "/Users/s06540/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/s06540/.sdkman/bin/sdkman-init.sh"

