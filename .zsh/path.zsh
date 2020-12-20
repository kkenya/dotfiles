#!/bin/bash

export PATH="/usr/local/sbin:$PATH"

# composer(php package manager)
if [[ -d "$HOME/.composer/vendor/bin" ]]; then
    export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# pyenv(python version manager)
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# mysql5.7
if [[ -d "/usr/local/opt/mysql@5.7/bin" ]]; then
    export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
fi

# aws cli
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH=~/.local/bin:$PATH
fi

# python version manager
if [[ -d "$HOME/.poetry/bin" ]]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# mongo
if [[ -d "usr/local/opt/mongodb-community@4.2/bin" ]]; then
    export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"
fi

# image magic
if [[ -d "/usr/local/opt/imagemagick@6/bin" ]]; then
    export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
fi

# sdkman(java sdk version manager)
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "/Users/s06540/.sdkman/bin/sdkman-init.sh"

