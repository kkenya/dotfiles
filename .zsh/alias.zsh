#!/bin/bash

# built in

alias reload!='. ~/.zshrc'
# a 隠しファイル
# h それぞれのカラムにヘッダを追加
alias ll="ls -lah"
# 削除に確認をする
alias rm="rm -i"
# 指定したコマンドパスやエイリアスを取得する
# a 同盟で実行可能なコマンドを全て表示
alias type="type -a"
# 指定したディレクトリのディスク量をhuman-readableな形で表示
alias du="du -h"
# 差分表示を色付きに
alias diff=colordiff
# .の複数指定で親のディレクトリに移動
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# install

# Replacement for 'ls' written in Rust. https://the.exa.website/
alias ls=exa
# vscodeをカレントディレクトリで開く
alias vs="code -r ."
alias vsi="code-insiders -r ."
