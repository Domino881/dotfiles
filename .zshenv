path+="${HOME}/.fzf/bin/"
path+="${HOME}/.local/tectonic/"
path+="/usr/local/texlive/2024/bin/x86_64-linux"
source "${HOME}/.cargo/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export VISUAL=nvim
export EDITOR=$VISUAL
export PATH
