source /etc/skel/.bashrc

####    USER    ####

####    aliases    ####
alias ls='ls -A --color=auto --group-directories-first'
alias latex='latex -output-format=pdf'
alias cpmf='cp ~/Documents/makefile .'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias bashrc='vim ~/.bashrc'
#make ranger change the shell directory
alias ranger='ranger --choosedir=$HOME/.rangerdir;cd "$(cat $HOME/.rangerdir)"'
alias colors='chromium https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg'
alias date='date +%d.%m.%Y\ %H:%M:%S\ %Z'
alias gnome-screenshot='gnome-screenshot -i'
alias droidcam-bg='droidcam-cli 192.168.90.124 4747 &'

####    enviroment variables    ####
COLOR1='\e[38;5;223m'
COLOR2='\e[38;5;102m'
ENDCOLOR='\e[00m'
export PROMPT_DIRTRIM=2
PS1="\[$COLOR1\]\u\[$ENDCOLOR\]:\[$COLOR2\]\w\[$ENDCOLOR\]\$"
unset color_prompt force_color_prompt

PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
PATH=/home/dominik/.local/bin/:$PATH

export BROWSER=/usr/bin/chromium
export TERMINAL=/usr/bin/urxvt
export EDITOR=/usr/bin/vim

export FZF_DEFAULT_COMMAND='find .'
export FZF_DEFAULT_OPTS='
--color=16
--height 30%
--layout reverse
--inline-info
'

####    bindings    ####
setxkbmap -option caps:escape
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind -x '"\C-p": fe'
git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

####    miscellaneous    ####
#fzf
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	  [[ -n "$files"  ]] && ${EDITOR:-vim} "${files[@]}"
}

#turn off bell
if [ -n "$DISPLAY" ]; then
	xset b off
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
