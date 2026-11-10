# Aliases

alias nano="echo Ahem\?"
alias ap="ansible-playbook"
alias icat="kitty +kitten icat"
alias calc="qalc"
alias fd="fd -L"
alias cim="nvim"
alias vim="nvim"
alias j="just"
alias pi='nono run --profile pi --allow-cwd --allow-launch-services --rollback -- pi'
alias less="bat"
alias ws="with-secrets"

# Human-readable sizes
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Linux-only helpers
alias temp="sensors 2> /dev/null | grep Tctl"
alias systemctl="systemctl --no-pager"

# kubernetes things
alias k="kubectl"

# Always use dotfile preprocessing with stow
alias stow="stow --dotfiles"

# https://unix.stackexchange.com/a/539771
alias oops=' remove_last_history_entry'

# kubernetes
use-kubeconfig() {
    export KUBECONFIG="$1"
    echo "KUBECONFIG set to: $KUBECONFIG"
}

# mkdir and cd in one
# https://unix.stackexchange.com/a/125386
mkcd ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# create a temp dir in ram and move there (macOS only)
mkcdtemp() {
  if [[ "$(uname)" != "Darwin" ]]; then
    echo "mkcdtemp is only supported on macOS" >&2
    return 1
  fi
  command ramdisk "$@"
  local rc=$?
  (( rc == 0 )) && [[ -d /Volumes/RAMDisk ]] && cd /Volumes/RAMDisk
  return $rc
}

# play sounds based on exit code
boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}

remove_last_history_entry() {
    # This sub-function checks if the argument passed is a number.
    # Thanks to @yabt on stackoverflow for this :).
    is_int() ( return $(test "$@" -eq "$@" > /dev/null 2>&1); )

    # Set history file's location
    history_file="${HOME}/.zsh_history"
    history_temp_file="${history_file}.tmp"

    # Check if the user passed a number,
    # so we can delete x lines from history.
    lines_to_remove=1
    if [ $# -eq 0 ]; then
        # No arguments supplied, so set to one.
        lines_to_remove=1
    else
        # An argument passed. Check if it's a number.
        if $(is_int "${1}"); then
            lines_to_remove="$1"
        else
            echo "Unknown argument passed. Exiting..."
            return
        fi
    fi

    fc -W # write current shell's history to the history file.

    # Get the files contents minus the last entry(head -n -1 does that)
    total_lines=$(wc -l < "$history_file")
    keep_lines=$((total_lines - lines_to_remove))
    sed -n "1,${keep_lines}p" "$history_file" > "$history_temp_file"

    mv "$history_temp_file" "$history_file"

    fc -R # read history file.
}
