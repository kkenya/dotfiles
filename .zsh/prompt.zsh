#!/bin/bash

# unstaged (*) and staged (+) changes will be shown next to the branch name.
GIT_PS1_SHOWDIRTYSTATE=true
#  If something is stashed, then a '$' will be shown next to the branch name.
#GIT_PS1_SHOWSTASHSTATE=false
#GIT_PS1_SHOWUPSTREAM
#GIT_PS1_DESCRIBE_STYLE
# If there're untracked files, then a '%' will be shown next to the branch name.
#GIT_PS1_SHOWUNTRACKEDFILES=false
# difference between HEAD and its upstream
#GIT_PS1_SHOWUPSTREAM=false
# colored hint about the current dirty state
GIT_PS1_SHOWCOLORHINTS=true
# If you would like __git_ps1 to do nothing in the case when the current directory is set up to be ignored by git
GIT_PS1_HIDE_IF_PWD_IGNORED=false
setopt PROMPT_SUBST
#PS1='%F{green}%n%f@%m[%F{cyan}%~%f]$(__git_ps1) %# '
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# shell state
#   %~ 作業ディレクトリ($HOMEで始まる場合~に置き換える)
# login information
#   %n $USERNAME.
#   %M ホスト名
#   %m ホスト名(数字指定がない場合最初の.まで)
#   %# A '#' if the shell is running with privileges, a '%' if not.
# visual effects
#   %F(%f) 色指定
PS1='%n[%F{cyan}%~%f]$(__git_ps1)%# '
