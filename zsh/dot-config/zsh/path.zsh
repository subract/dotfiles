# PATH setup

# allow using krew plugins
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# use ~/bin for scripts
export PATH="$HOME/bin:$PATH"

# Add paths on MacOS
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

# Add go paths to path (guard against empty GOBIN creating an empty PATH entry)
if command -v go >/dev/null 2>&1; then
  path+=("$(go env GOPATH 2>/dev/null)/bin")
  [[ -n "$(go env GOBIN 2>/dev/null)" ]] && path+=("$(go env GOBIN)")
fi
