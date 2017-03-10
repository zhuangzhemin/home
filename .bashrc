#!/system/bin/sh

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export PS1="[\u:\w]\$"

#export PREFIX="/data/data/com.termux/files/usr"
#export LD_LIBRARY_PATH="/data/data/com.termux/files/usr/lib"
#export PATH="$PREFIX/bin:$PATH"
#export PATH="$PREFIX/bin/applets:$PATH"

# some more ls aliases
alias ll='ls -alh'
alias la='ls -ah'
alias du='du -h'

alias md='mkdir -p'

alias ta='tmux attach'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias gohome="cd /sdcard/home"
alias gobin="cd $PREFIX/bin"
alias vi="vim"
alias yum="apt"

alias ec="vim ~/.bashrc"
alias sc="source ~/.bashrc"

alias vps="ssh root@104.207.152.19"

alias mrw="mount -o remount,rw /system"
alias mro="mount -o remount,ro /system"

export ROOT_HOME="/data/data/com.termux/files/home/root"
export ROOT_SHELL="$PREFIX/bin/bash"
alias su="/su/bin/su -c \"HOME=$ROOT_HOME $ROOT_SHELL\" --login"
