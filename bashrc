
# If not running interactively, don't do anything.
[ -z "$PS1" ] && retn

# Ignore repeated commands in .bash_history
export HISTCONTROL=ignoredups
# Default editor is vim.
export EDITOR=vim
export VISUAL=vim

export PATH="/home/markn/anaconda3/bin:$PATH"
# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"
# Never write bytecode for python.
export PYTHONDONTWRITEBYTECODE=0

# Make tmux able to use 256 colours.
alias tmux="TERM=screen-256color-bce tmux"

# Better grep defaults
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# System monitoring shortcuts
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]$(parse_git_branch)\[\033[00m\] $ "

# Fix the git branch in prompt to update dynamically
PROMPT_COMMAND='PS1="\u@\h \W\[\033[32m\]$(parse_git_branch)\[\033[00m\] $ "'


# Enable programmable completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
