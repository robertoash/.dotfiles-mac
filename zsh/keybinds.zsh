
# history substring search options
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

#bindkey '^a' beginning-of-line
#bindkey '^e' end-of-line

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

