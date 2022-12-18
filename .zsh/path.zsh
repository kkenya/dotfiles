#!/bin/bash

# Homebrew
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
# installed packages
export PATH="$(brew --prefix)/bin:$PATH"

# git(https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh)
# allows you to see repository status in your prompt.
[[ -s "${HOME}/.git-prompt.sh" ]] && . "${HOME}/.git-prompt.sh"
# include git-completion.zsh
fpath=(${HOME}/.zsh/functions ${fpath})

# nvm(node version manager)
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
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
