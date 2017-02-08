# Updates editor information when the keymap changes.
function zle-line-init zle-keymap-select {
    PROMPT='%{$fg[cyan]%}[%n:%~]$(git_prompt_info)$(vi_mode_prompt_info) '
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle &&  zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line


bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

function vi_mode_prompt_info() {
  CMD_MODE_INDICATOR="%{$fg_bold[red]%}%#%{$reset_color%}"
  INS_MODE_INDICATOR="%{$fg_bold[green]%}%#%{$reset_color%}"
  echo "${${KEYMAP/vicmd/$CMD_MODE_INDICATOR}/(main|viins)/$INS_MODE_INDICATOR}"
}

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || return 0
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"
