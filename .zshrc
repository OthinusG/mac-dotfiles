# >>> brew >>>
	export HOMEBREW_PIP_INDEX_URL=http://mirrors.aliyun.com/pypi/simple
	export HOMEBREW_API_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles/api
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
	eval $(/opt/homebrew/bin/brew shellenv)
# <<< brew initialize <<<

# >>> macports >>>
	export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# <<< macports initialize <<<

# >>> wezterm >>>
	PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
	export PATH
# <<< wezterm initialize <<<

# >>> starship >>>
	eval "$(starship init zsh)"
	source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
	ZSH_HIGHLIGHT_STYLES[path]=none
 	ZSH_HIGHLIGHT_STYLES[path_prefix]=none
 	source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# <<< starship initialize <<<

# >>> curl >>>
	export PATH="/opt/homebrew/opt/curl/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
	PATH=~/.local/bin/:$PATH
# <<< curl initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wqin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wqin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/wqin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wqin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

