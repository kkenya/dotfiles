#!/bin/bash

## npm

# npm補完スクリプトの読み込み
load-npm-completion () {
  ###-begin-npm-completion-###
  #
  # npm command completion script
  #
  # Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
  # Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
  #
  ###-begin-npm-completion-###
  #
  # npm command completion script
  #
  # Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
  # Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
  #
  if type complete &>/dev/null; then
    _npm_completion() {
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
      compadd -- $(COMP_CWORD=$((CURRENT - 1)) \
        COMP_LINE=$BUFFER \
        COMP_POINT=0 \
        npm completion -- "${words[@]}" \
        2>/dev/null)
      IFS=$si
    }
    compdef _npm_completion npm
  elif type compctl &>/dev/null; then
    _npm_completion() {
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

  source <(npm completion)
  ###-end-npm-completion-###
}

# 1度目の呼び出しのみnpmコマンドをラップして補完スクリプトを読み込む
npm() {
  # npm関数を削除し、以降のnpm実行でラップした関数を呼ばない
  # If -f is specified, each name refers to a shell function, and the  function  definition is  removed.
  unset -f npm
  load-npm-completion
  npm $@
}

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
