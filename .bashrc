#
# ~/.bashrc
#

source ~/.git-prompt.sh
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWDIRTYSTATE=true

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
screenfetch
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano
# <<< END ADDED BY CNCHI INSTALLER

# Git aliases
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gp="git push"
alias gco="git checkout"
alias gst="git status"
