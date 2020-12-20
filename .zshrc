# zshrcが読みこれまれている場合読み込みをスキップする
if [[ -z $ZSH_ENV_LOADED ]]; then
  export PATH="${HOME}/local/bin:${PATH}"
  export ZSH_ENV_LOADED="loaded"
else
  print "skipped to read .zshenv\n"
fi

# dotfilesで管理しない設定を読み込み
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# zsh設定ファイルのpathを指定
export ZSH_HOME="$HOME/.zsh"
# typeset 変数と関数に値と属性を設定する
typeset config_files
# 配列に.zshの拡張子のファイルパスを代入
config_files=($ZSH_HOME/**/*.zsh)
# 各ファイルを読み込み
for file in $config_files
do
    echo $file
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

fpath+=~/.zfunc

autoload -Uz compinit
compinit

# zshrc.zwcが古い場合にコンパイルする
if [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
   zcompile ~/.zshrc
fi

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi

# 単語の区切りとみなさない文字を定義する
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# ^uでカーソルから行頭までを削除
# default kill-whole-line
bindkey \^U backward-kill-line

