#!/bin/bash

# ディレクトリを作した後にカレントディレクトリを作成したディレクトリに移動する
mkcd() {
    mkdir $1 && cd $_
}

# ディレクトリ検索
findd() {
    mdfind -onlyin ~ $1
}

# find /etc/httpd  -type f -print | xargs grep 'VirtualHost'
# grep -n -3 master

# lsof -i:28017 | awk '{ print $2 }' | xargs kill -9
# lsof -i:9080 | sed -e '1d' | awk '{ print $2 }' | xargs kill
# ps | grep 4mac | awk '{ print $1 }' | xargs kill -9

# fcd - cd to selected directory
fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2>/dev/null | fzf +m) &&
        cd "$dir"
}
