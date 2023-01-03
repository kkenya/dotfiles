# dotfilesで管理しない設定を読み込む
if [ -e ${HOME}/.localrc ]; then
  source ${HOME}/.localrc
fi

typeset config_files
# 配列に.zshの拡張子のファイルパスを代入
config_files=(${HOME}/.zsh/**/*.zsh)
for file in ${config_files}; do
  source $file
done

HISTFILE="${HOME}/.zsh_history"
# メモリに保存される履歴の件数
HISTSIZE=1000000000
# 履歴ファイルに保存される履歴の件数
SAVEHIST=1000000000
# 履歴に開始時刻と経過秒数を記録する
setopt EXTENDED_HISTORY
# 入力したコマンドが履歴に存在するなら、古い履歴が削除される
setopt HIST_IGNORE_ALL_DUPS
# 前回と同じコマンドを履歴に追加しない
setopt HIST_IGNORE_DUPS
# 履歴を共有する
setopt SHARE_HISTORY

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

# fpathにある関数を自動読み込みする
# -U 関数の読み込み時に定義済みのエイリアスを展開しない
autoload -U compinit
# compauditの実行時間がボトルネックとなるため、compinitの実行からの経過時間が24時間より小さいならスキップする
local now=$(date +"%s")
local updated=$(date -r ~/.zcompdump +"%s")
local threshold=$((60 * 60 * 24))
if [ $((${now} - ${updated})) -gt ${threshold} ]; then
  compinit
else
  # if there are new functions can be omitted by giving the option -C.
  compinit -C
fi

# 大文字、小文字を無視して補完する
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# zshrc.zwcが古い場合にコンパイルする
if [ ${HOME}/.zshrc -nt ${HOME}/.zshrc.zwc ]; then
  zcompile ${HOME}/.zshrc
fi

# 単語の区切りとして扱わない文字を定義する
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# ^uでカーソルから行頭までを削除する
# default kill-whole-line
bindkey \^U backward-kill-line

# tmuxなどで複数のシェルを開始した場合に重複したパスを修正する
typeset -U PATH

# profile zsh
type zprof &> /dev/null
if [ $? = 0 ]; then
      zprof
fi
