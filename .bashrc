# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias vi='gvim'
alias ll='ls -lh'
alias la='ls -ah'

alias ec='gvim ~/.bashrc'
alias sc='source ~/.bashrc'
stty -ixon

