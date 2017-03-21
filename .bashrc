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
alias ll='ls -alh'
alias la='ls -Ah'

alias ec='vim ~/.bashrc'
alias sc='source ~/.bashrc'
stty -ixon

