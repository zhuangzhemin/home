#!/system/bin/sh

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export PS1="[\u:\w]\$"

export PREFIX="/data/data/jackpal.androidterm/files/usr"
export LD_LIBRARY_PATH="/data/data/jackpal.androidterm/files/usr/lib"
export PATH="$PREFIX/bin:$PATH"
export PATH="$PREFIX/bin/applets:$PATH"

# some more ls aliases
alias ll='ls -alh'
alias la='ls -ah'
alias du='du -h'

alias gohome="cd /sdcard/home"
alias gobin="cd $PREFIX/bin"
alias vi="vim"

alias ec="vim ~/.bashrc"
alias sc="source ~/.bashrc"

alias vps="ssh zhemin@45.63.50.237"

alias mrw="mount -o remount,rw /system"
alias mro="mount -o remount,ro /system"

export ROOT_HOME="$HOME/root"
export ROOT_SHELL="$PREFIX/bin/bash"
alias su="/su/bin/su -c \"HOME=$ROOT_HOME $ROOT_SHELL\" --login"
