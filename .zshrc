# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -Uz compinit && compinit

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^k' autosuggest-accept
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' menu no
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
TERM=xterm-256color
PROMPT=$'%m %F{green}%~%f: '

export PATH=/home/dkuczynski/nvim-linux64/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
nvim --version &> /dev/null && export VISUAL=nvim; alias vim=nvim
nvim --version &> /dev/null || export VISUAL=vim; unalias vim
export EDITOR="$VISUAL"
export P4EDITOR="$VISUAL"
export P4MERGE="amergeVim"

fzf --version || ( git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)
# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
