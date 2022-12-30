## zshrcが読みこれまれている場合読み込みをスキップする
#if [[ -z ${ZSH_ENV_LOADED} ]]; then
#  export PATH="${HOME}/local/bin:${PATH}"
#  export ZSH_ENV_LOADED="loaded"
#else
#  print "skipped to read .zshenv\n"
#fi

# dotfilesで管理しない設定を読み込む
if [[ -e ${HOME}/.localrc ]]; then
  source ${HOME}/.localrc
fi

# zsh設定ファイルのpathを指定
export ZSH_HOME="${HOME}/.zsh"
# typeset 変数と関数に値と属性を設定する
typeset config_files
# 配列に.zshの拡張子のファイルパスを代入
config_files=(${ZSH_HOME}/**/*.zsh)
for file in ${config_files}; do
  echo "load file: ${file}"
  source $file
done

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
# 大文字、小文字を無視して補完する
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

fpath+=${HOME}/.zfunc

autoload -Uz compinit
compinit

# zshrc.zwcが古い場合にコンパイルする
if [[ ${HOME}/.zshrc -nt ${HOME}/.zshrc.zwc ]]; then
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
