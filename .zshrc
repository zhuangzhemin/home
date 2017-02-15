# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set name of the theme to load.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME=

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode)

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file (~/.zsh/lib/*.zsh); do
    source $config_file
done

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
    if [ -f ~/.zsh/plugins/$plugin/$plugin.plugin.zsh ]; then
        source ~/.zsh/plugins/$plugin/$plugin.plugin.zsh
    fi
done

if [ ! "$ZSH_THEME" = ""  ]; then
    if [ -f ~/.zsh/themes/$ZSH_THEME.zsh-theme ]; then
        source ~/.zsh/themes/$ZSH_THEME.zsh-theme
    fi
fi

# User configuration

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'

alias ta='tmux attach'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias cls="clear"

export PREFIX="/data/data/com.termux/files/usr"
export LD_LIBRARY_PATH="/data/data/com.termux/files/usr/lib"
export PATH="$PREFIX/bin:$PATH"
export PATH="$PREFIX/bin/applets:$PATH"

# some more ls aliases
alias ll='ls -alh'
alias la='ls -ah'
alias du='du -h'

alias gohome="cd /sdcard/home"
alias gobin="cd $PREFIX/bin"
alias vi="vim"
alias yum="apt"

alias ec="vim ~/.zshrc"
alias sc="source ~/.zshrc"

alias vps="ssh zhemin@45.63.50.237"
alias vpsr="ssh root@45.63.50.237"

alias mrw="mount -o remount,rw /system"
alias mro="mount -o remount,ro /system"

export ROOT_HOME="/data/data/com.termux/files/home/root"
export ROOT_SHELL="$PREFIX/bin/zsh"
alias su="/su/bin/su -c \"HOME=$ROOT_HOME $ROOT_SHELL\" --login"
