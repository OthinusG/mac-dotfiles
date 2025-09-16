#wezterm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
# Starship
eval "$(starship init zsh)"
#
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
 ZSH_HIGHLIGHT_STYLES[path]=none
 ZSH_HIGHLIGHT_STYLES[path_prefix]=none
#
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
