# Run neofetch
neofetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history

# default apps
export EDITOR="nano"

# aliases
[ -f "${XDG_CONFIG_HOME}/shell/aliases" ] && source "${XDG_CONFIG_HOME}/shell/aliases"
alias ll="eza --all --color=always --icons --group-directories-first --git -Hah"
alias lll="ll -l -a"
alias lls="lll -s size"
alias llt="ll -T -L"
alias vim="vim -u ~/.config/vim/vimrc"
alias delete_gone_branches="git branch -vv | awk '$0 ~ /: gone]/ {print $1;}' | xargs -r git branch -D"
alias "??"="gh copilot suggest -t shell "
alias "??g"="gh copilot suggest -t git "
alias "??gh"="gh copilot suggest -t gh "
alias "??x"="gh copilot explain "

# options
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


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# #################################
# # Path setting
# #################################

# Pipx path
export PATH="$PATH:/Users/robertoash/.local/bin"


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
# # App Specific Commands
# #################################

# Thefuck
eval $(thefuck --alias fuck)
# Resh
[[ -f ~/.resh/shellrc ]] && source ~/.resh/shellrc

# LF (set cwd on exit)
LFCD="/home/rash/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
# Hook direnv
eval "$(direnv hook zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Change vimrc location
#export VIMINIT='source $MYVIMRC'
#export MYVIMRC='~/.config/vim/vimrc'

# Gcloud
# Set correct python
export GCLOUDSDK_PYTHON='/Users/robertoash/.asdf/shims/python'
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


