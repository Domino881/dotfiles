# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dkuczynski/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dkuczynski/.fzf/bin"
fi

eval "$(fzf --bash)"
