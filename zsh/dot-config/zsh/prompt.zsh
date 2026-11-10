# Prompt: starship (https://starship.rs) + terminal window title
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# terminal tab/window title: cwd at rest, running command while executing
_zsh_title_precmd() { print -Pn '\e]2;%n@%m: %~\a' }
_zsh_title_preexec() { print -Pn "\e]2;$1\a" }
add-zsh-hook precmd _zsh_title_precmd
add-zsh-hook preexec _zsh_title_preexec
