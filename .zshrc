# dotfilesで管理しない設定を読み込む
if [ -e ${HOME}/.localrc ]; then
  source ${HOME}/.localrc
fi

typeset config_files
# 配列に.zshの拡張子のファイルパスを代入
config_files=(${HOME}/.zsh/**/*.zsh)
for file in ${config_files}; do
  echo "load file: ${file}"
  source $file
done

HISTFILE="${HOME}/.zsh_history"
# メモリに保存される履歴の件数
# HISTSIZE=1000000000
HISTSIZE=50000
# 履歴ファイルに保存される履歴の件数
# SAVEHIST=1000000000
SAVEHIST=10000
# 履歴に開始時刻と経過秒数を記録する
setopt EXTENDED_HISTORY
# 入力したコマンドが履歴に存在するなら、古い履歴が削除される
# setopt HIST_IGNORE_ALL_DUPS
# 前回と同じコマンドを履歴に追加しない
setopt HIST_IGNORE_DUPS
# 履歴を共有する
# setopt SHARE_HISTORY

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

# fpathにある関数を自動読み込みする
# -U 関数の読み込み時に定義済みのエイリアスが展開されない
autoload -U compinit
# 補完機能を初期化する
compinit

# 大文字、小文字を無視して補完する
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# zshrc.zwcが古い場合にコンパイルする
if [ ${HOME}/.zshrc -nt ${HOME}/.zshrc.zwc ]; then
  zcompile ${HOME}/.zshrc
fi

# 単語の区切りとして扱わない文字を定義する
export WORDCHARS="*?_-.[]${HOME}=&;!#$%^(){}<>"

# ^uでカーソルから行頭までを削除
# default kill-whole-line
bindkey \^U backward-kill-line

# profile zsh
which type > /dev/null 2>&1
if [ $? = 0 ]; then
      zprof
fi

# tmuxなどで複数のシェルを開始した場合に重複したパスを修正する
typeset -U PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
