# Options, history, completion and keybindings

# History settings
setopt HIST_IGNORE_SPACE      # Put a space at the start of a command to keep it out of history
setopt HIST_IGNORE_DUPS       # Don't save sequential duplicate entries
setopt HIST_FIND_NO_DUPS      # Hide dups when searching history
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from history items
setopt SHARE_HISTORY          # Share history between instances (implies INC_APPEND_HISTORY)
setopt HIST_VERIFY            # Don't execute immediately after history expansion

# Completion

# Enable completion
# https://stackoverflow.com/questions/66338988/complete13-command-not-found-compdef
fpath=(~/.zsh/completions $fpath)
# add Homebrew completions (macOS only, when brew is installed)
if [[ "$(uname)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi
# add personal bin completions
fpath=($HOME/bin/completions $fpath)
autoload -Uz compinit
# Only regenerate the completion dump if it's older than 24h
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Highlight selection in completion menu
zstyle ':completion:*' menu select

# Better completion for kill command
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'

# Keybindings

# Make Ctrl+U work as expected
bindkey \^U backward-kill-line
