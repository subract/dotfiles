# Options, history, completion and keybindings

# History sizing (previously provided by oh-my-zsh)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History settings
setopt EXTENDED_HISTORY        # record timestamps in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST  # expire duplicates first when HISTSIZE is exceeded
setopt HIST_IGNORE_SPACE      # Put a space at the start of a command to keep it out of history
setopt HIST_IGNORE_DUPS       # Don't save sequential duplicate entries
setopt HIST_FIND_NO_DUPS      # Hide dups when searching history
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from history items
setopt SHARE_HISTORY          # Share history between instances (implies INC_APPEND_HISTORY)
setopt HIST_VERIFY            # Don't execute immediately after history expansion

# Directory navigation (previously provided by oh-my-zsh)
setopt AUTO_CD                # type a directory name to cd into it
setopt AUTO_PUSHD             # cd pushes the old dir onto the directory stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

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

# Completion behaviour (previously provided by oh-my-zsh)
unsetopt MENU_COMPLETE        # don't autoselect the first completion entry
unsetopt FLOWCONTROL
setopt AUTO_MENU              # show menu on successive tab press
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
zstyle ':completion:*' special-dirs true       # complete ../ and /
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle '*' single-ignored show

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

# Emacs-style line editing (previously provided by oh-my-zsh)
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search     # ↑ history search
bindkey '^[[B' down-line-or-beginning-search   # ↓ history search
bindkey '^[[1;5C' forward-word                 # ctrl-→
bindkey '^[[1;5D' backward-word                # ctrl-←
bindkey '^[[3~' delete-char                    # delete
bindkey '^[[3;5~' kill-word                    # ctrl-delete
bindkey '^?' backward-delete-char
zmodload zsh/complist                # provides the menuselect keymap
bindkey -M menuselect '^o' accept-and-infer-next-history

# Make Ctrl+U work as expected
bindkey \^U backward-kill-line

# Appearance (previously provided by oh-my-zsh)
if [[ "$OSTYPE" == darwin* ]]; then
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls='ls -G'
else
  [[ -z "$LS_COLORS" ]] && command -v dircolors >/dev/null 2>&1 && source <(dircolors -b)
  alias ls='ls --color=tty'
fi
command diff --color /dev/null /dev/null >/dev/null 2>&1 && alias diff='diff --color'
