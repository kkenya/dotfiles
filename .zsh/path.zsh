#!/bin/bash

# homebrew installed packages
export PATH="$(brew --prefix)/bin:$PATH"

# git(https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh)
# allows you to see repository status in your prompt.
[ -s "${HOME}/.git-prompt.sh" ] && . "${HOME}/.git-prompt.sh"
# include git-completion.zsh
fpath=(${HOME}/.zsh/functions ${fpath})

# coreutils
# BSD系のコマンドをGNU系に置き換える
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
