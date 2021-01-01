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
#PS1='[%F{green}%n%f@%m %c$(__git_ps1 " (%s)")]\$ '
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PS1='%F{green}%n%f@%m[%F{cyan}%~%f]$(__git_ps1) %# '

