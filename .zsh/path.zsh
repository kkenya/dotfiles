#!/bin/bash

# todo: brew prefixの速度計測で利用を検討

# installed packages
export PATH="$(brew --prefix)/bin:$PATH"

# git(https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh)
# allows you to see repository status in your prompt.
[ -s "${HOME}/.git-prompt.sh" ] && . "${HOME}/.git-prompt.sh"
# include git-completion.zsh
fpath=(${HOME}/.zsh/functions ${fpath})

## nvm(node version manager)

# シェル初期化時にnvmの初期化を呼び出すとボトルネックになるため、zshのフックを利用して遅延させる
load-nvm() {
  # nvmが利用できなければ初期化する
  if ! type nvm &>/dev/null; then
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi
}

# Calling nvm use automatically in a directory with a .nvmrc file
# https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  # READMEのスクリプトにnvmの初期化を追加
  load-nvm
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
  local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
      fi
    elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
# シェル初期化時にボトルネックになるので実行しない(ディレクトリを移動すればhookで実行される。必要ならload-nvmrcを呼び出す)
# load-nvmrc
