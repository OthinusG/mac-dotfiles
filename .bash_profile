#!/bin/bash

# if [ -x "$(command -v gdata)" ]; then
# 	PS4='+ $(gdate "+%s.%N")\011 '
# else
# 	PS4='+ $(date "+%s.%N")\011 '
# fi
# exec 3>&2 2>/tmp/bashstart.$$.log
# set -x
source ~/.bashrc
# set +x
# exec 2>&3 3>&-

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

