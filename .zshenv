export NVIM_PATH="${HOME}/.local/nvim-linux-x86_64/bin/nvim"

path+=${NVIM_PATH%\/nvim}
path+="${HOME}/.fzf/bin/"
path+="${HOME}/.local/tectonic/"
path+="/usr/local/texlive/2024/bin/x86_64-linux"
source "${HOME}/.cargo/env"

export VISUAL=nvim
export EDITOR=$VISUAL
export PATH
