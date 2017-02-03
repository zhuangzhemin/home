# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

alias vi='vim'
alias ls='ls -hF --color=auto'                 # classify files in colour
alias ll='ls -AlhF --color=auto'
alias llt='ls -AlhF -rt --color=auto'
alias la='ls -ahF --color=auto'

alias ec='vim ~/.bashrc'
alias sc='source ~/.bashrc'
stty -ixon

alias yum="apt-cyg"
alias sysupdate="/usr/bin/setup --no-desktop --no-shortcuts --no-startmenu --quiet-mode --upgrade-also --site http://mirrors.163.com/cygwin/"

