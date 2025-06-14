# Download Zinit, if it's not there yet
if [ ! -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit" ]; then
   bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load completions
autoload -U compinit && compinit
autoload -U colors && colors

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^y' autosuggest-accept
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^u' backward-kill-line
bindkey '^j' backward-word
bindkey '^k' forward-word
bindkey '^w' backward-kill-word
bindkey "^[[3~" delete-char

# History
HISTSIZE=50000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaaa"

# List recent nvim files
_list_oldfiles() {
    # Get the oldfiles list from Neovim
    local oldfiles=($(nvim -u NONE --headless +'lua io.write(table.concat(vim.v.oldfiles, "\n") .. "\n")' +qa))
    # Filter invalid paths or files not found
    local valid_files=()
    for file in "${oldfiles[@]}"; do
        if [[ -f "$file" ]]; then
            valid_files+=("$file")
        fi
    done
    # Use fzf to select from valid files
    local files=($(printf "%s\n" "${valid_files[@]}" | \
        grep -v '\[.*' | \
        fzf --multi \
        --preview 'bat -n --color=always --line-range=:500 {} 2>/dev/null || echo "Error previewing file"' \
        --layout=default))

  [[ ${#files[@]} -gt 0 ]] && nvim "${files[@]}"
}
zle -N _list_oldfiles
bindkey '^f' _list_oldfiles

# Ctrl-z to fg a suspended process
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

export TMUX_CONF="$HOME/.config/tmux/.tmux.conf"

# Aliases
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"
alias ls='ls --color -ah'
alias icat='kitten icat'
alias pdf2htmlEX='docker run -ti --rm -v "`pwd`":/pdf -w /pdf pdf2htmlex/pdf2htmlex:0.18.8.rc2-master-20200820-ubuntu-20.04-x86_64'
alias vim="$VISUAL"
alias rm="trash-put"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export BIBINPUTS="$HOME/Library/texmf/bibtex/bib"

fzf --version &> /dev/null || ( git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install)

export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git,.wine,.steam,node_modules,timeshift"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git,node_modules,.steam,.wine,timeshift"

export FZF_ALT_C_OPTS="--preview 'tree -C {} -L 1'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"

# Shell integrations
eval "$(fzf --zsh)"

# Colorful man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zoxide
eval "$(zoxide init zsh)"
alias cd=z
