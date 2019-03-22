#!/bin/bash

set -e
DOT_DIR="${HOME}/dotfiles"
REPOSITORY="git@github.com:kkenya/dotfiles.git"

usage() {
    CMD_NAME=`basename $0`
    cat << _EOT_ 1>&2
Usage:
    $CMD_NAME [<options>]

Options:
    -f
    -h  print usage
_EOT_
    exit 1
}

is_installed() {
    type $1 > /dev/null 2>&1
}

while getopts fh: OPT
do
  case $OPT in
    "f" )
        FLG_A="TRUE"
        ;;
    "h" )
        usage
        ;;
    * )
        usage
        ;;
  esac
done

shift $((OPTIND - 1))

# confirm that  brew is installed
if is_installed "brew"; then
    echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
else
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew"
brew doctor
brew update

# confirm that dotfiles directory exists
if [ ! -d ${DOT_DIR} ]; then
    echo "Downloading dotfiles..."
    mkdir ${DOT_DIR}

    if is_installed "git"; then
        git clone ${REPOSITORY}
    fi
    echo "Download dotfiles is completed!"
else
    echo "Dotfiles already exists" 1>&2
    exit 1
fi

cd ${DOT_DIR}

for f in .??*
do
    [[ ${f} = ".git" ]] && continue
    # n option replace symlink
    ln -fnsv ${DOT_DIR}/${f} ${HOME}/${f}
done

echo "Deploy dotfiles completed"

exit 0
