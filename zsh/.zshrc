# #################################
# # Evals & Path setting
# #################################

# Brew
eval "$(/usr/local/bin/brew shellenv)"
# Thefuck
eval $(thefuck --alias fuck)
# Activate asdf
. $(brew --prefix asdf)/libexec/asdf.sh
# Load direnv
eval "$(direnv hook zsh)"
# Pipx path
export PATH="$PATH:/Users/robertoash/.local/bin"


# #################################
# # Load on startup
# #################################

# Run neofetch
neofetch


# #################################
# # Powerlevel10k
# #################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# #################################
# # History & Cache
# #################################

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history


# #################################
# # Environment Variables
# #################################

# Plain
export EDITOR="nano"
export TERMINAL="alacritty"
export _Z_DATA=~/.config/z/.z
export ZELLIJ_CONFIG_FILE=~/.config/zellij/config.kdl

# Set correct python for Gcloud
export GCLOUDSDK_PYTHON='/Users/robertoash/.asdf/shims/python'

# Change vimrc location
#export VIMINIT='source $MYVIMRC'
#export MYVIMRC='~/.config/vim/vimrc'


# #################################
# # Options
# #################################

unsetopt menu_complete
unsetopt flowcontrol
setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history_time
setopt share_history
autoload -U compinit; compinit
zstyle ':completion:*' menu select


# #################################
# # Sourcing
# #################################

# Oda
source ~/.config/zsh/.oda.zsh
# Aliases
source ~/.config/zsh/.zsh_aliases
# Keybinds
source ~/.config/zsh/keybinds.zsh
# Theme
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
# Plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/zsh-z/zsh-z.plugin.zsh
# Functions
source ~/.config/zsh/.zsh_functions
# Prompt Customization & Utilities
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


# #################################
# # Keybindings
# #################################

source ~/.config/zsh/keybinds.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s '^o' 'lfcd\n'


# #################################
# # Miscellaneous Configurations
# #################################

# Auto Notify
AUTO_NOTIFY_IGNORE+=("lf" "hugo serve" "rofi")
# Suggestion Strategy
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


# #################################
# # App Specific
# #################################

# Resh
[[ -f ~/.resh/shellrc ]] && source ~/.resh/shellrc

# LF (set cwd on exit)
LFCD="/home/rash/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/robertoash/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/robertoash/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/robertoash/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/robertoash/google-cloud-sdk/completion.zsh.inc'; fi

# SGPT shell integration
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh


