# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dominik/.fzf/build/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dominik/.fzf/build/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dominik/.fzf/build/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/dominik/.fzf/build/fzf/shell/key-bindings.bash"
