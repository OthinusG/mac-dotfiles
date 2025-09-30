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

# >>> Added by Spyder >>>
alias uninstall-spyder=/Users/wqin/Library/spyder-6/uninstall-spyder.sh
# <<< Added by Spyder <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

