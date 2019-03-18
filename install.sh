#!/bin/bash

set -e
DOT_DIR="${HOME}/dotfiles"
REPOSITORY="git@github.com:kkenya/dotfiles.git"

if [ ! -d ${DOT_DIR} ]; then
    echo "Downloading dotfiles..."
    mkdir ${DOT_DIR}

    if type "git" > /dev/null  2>&1; then
        git clone ${REPOSITORY}
    fi
    echo "Download dotfiles is complete!"
fi

cd ${DOT_DIR}

for f in .??*
do
    [[ ${f} = ".git" ]] && continue
    # n option replace symlink
    ln -fnsv ${DOT_DIR}/${f} ${HOME}/${f}
done

echo "Deploy dotfiles completed"
