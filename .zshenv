path+="${HOME}/.fzf/bin/"
path+="${HOME}/.local/tectonic/"
path+="/usr/local/texlive/2025/bin/x86_64-linux/"
path+="/usr/local/Wolfram/Wolfram/14.2/Executables/"
source "${HOME}/.cargo/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export VISUAL=/home/linuxbrew/.linuxbrew/bin/nvim
export EDITOR=$VISUAL
export PATH

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:$PKG_CONFIG_PATH"
. "$HOME/.cargo/env"

# Colorscheme sync with wallpaper
# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)
