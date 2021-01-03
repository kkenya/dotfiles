# ^wで削除する単語の境界に/を含める
if [[ -t 1 ]]; then
    stty werase undef
    bind '"\C-w":unix-filename-rubout'
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bash 4+ required
# READLINE_LINE The contents of the Readline line buffer, for use with ‘bind -x’
# READLINE_POINT The position of the insertion point in the Readline line buffer, for use with ‘bind -x’
function peco-ghq(){
    local SELECTED=$(ghq list --full-path | peco --query "${READLINE_LINE}")
    if [[ -n "${SELECTED}" ]]; then
        READLINE_LINE="cd ${SELECTED}"
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
    local PRE_COUNT=$((COUNT-1))

    if [[ "$PRE_COUNT" == 0 ]] ; then
        # HISTCMD 'The history number, or index in the history list, of the current command. If HISTCMD is unset, it loses its special properties, even if it is subsequently reset.'
        # remove history 'peco-history'
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
    fi

    # fc -l $PRE_COUNT '最近のコマンド$PRE_COUNT個が出力されます'
    # -k POS1[,POS2] '-K POS1[,POS2] ソートフィールド指定の POSIX 形式。今後はこちらが推奨される。行の POS1 から POS2 までのフィールドを指定する。 POS2 を含む。 POS2 が省略されたら行末まで。 フィールドと文字位置はそれぞれ 0 から数えはじめる。'
    # sort -k 2 '２番めのフィールドで並び替える "1852	 git s" ならコマンドの入力履歴である "git s"が対償のフィールドになる'
    # sort -k 2 -k 1 'ソート条件を指定する場合-kを複数書く'
    # sort -b '各行の比較の際に、行頭の空白を無視する。'
    # uniq -f 1 '区切り文字で区切られたフィールドの１つ目を無視する'
    #local SELECTED=$(fc -l -$PRE_COUNT | sort -b -k 2,2 -k 1nr,1 | uniq -f 1 | sed -E 's/^[0-9]+[[:blank:]]+//' | peco --query "${READLINE_LINE}") 
    #local  SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[0-9]+[[:blank:]]+//' | sort | uniq | peco | head -n 1)
    local SELECTED=$(fc -l -$PRE_COUNT | sed -E 's/^[0-9]+[[:blank:]]+//' | sort | uniq | peco --query "${READLINE_LINE}")
        READLINE_LINE="${SELECTED}"
        READLINE_POINT=${#READLINE_LINE}
}
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

# start corrent directory in an opened window
alias vs="code -r ."
alias ins="code-insiders -r ."

#find /etc/httpd  -type f -print | xargs grep 'VirtualHost'
