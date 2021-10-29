source /etc/skel/.bashrc
####    USER    ####

####    aliases    ####
alias ls='ls -h -A --color=auto --group-directories-first --indicator-style=slash -r -t -G'
alias latex='latex -output-format=pdf'
alias cpmf='cp ~/Documents/makefile .'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias bashrc='vim ~/.bashrc'
#make ranger change the shell directory
alias ranger='ranger --choosedir=$HOME/.rangerdir'
alias colors='chromium https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg'
alias date='date +%d.%m.%Y\ %H:%M:%S\ %Z'
alias gnome-screenshot='gnome-screenshot -i'
alias droidcam-bg='droidcam-cli 192.168.90.124 4747 &'
alias gitall='git add --update && git commit && git push origin master'
alias grep='grep --color'
alias fzfapt='bash /home/dominik/.config/i3/fzfapt.sh'
alias dragon='dragon -x'
alias registax6='wine "C:\Program Files (x86)\RegiStax 6\RegiStax6.exe"'

####    enviroment variables    ####
COLOR1='\e[38;5;223m'
COLOR2='\e[38;5;102m'
ENDCOLOR='\e[00m'


_pwd() {
	_PWD=${PWD/#$HOME/\~}
	charlimit=`tput cols`
	charlimit=$((charlimit / 10 + 10))
	if [[ `echo -n $_PWD | wc -c` -gt $charlimit ]]; then
		prefix="…/"
		if [[ $charlimit -lt 15 ]]; then
			_PWD=`echo -n $_PWD | awk -F "/" '{print $NF}'`
		else
			_PWD=`echo -n $_PWD | awk -F "/" '{print $(NF-1) "/" $NF}'`
		fi
		_PWD="${prefix}${_PWD}"
	fi
	echo $_PWD
}
export PS1="\[$COLOR1\]\u\[$ENDCOLOR\]:\[$COLOR2\]\$(_pwd)\[$ENDCOLOR\]\$"
unset color_prompt force_color_prompt

__fzf_cd2__() {
	DIR=`find -type d -not -iname ".git" | fzf`
	[[ -z $DIR ]] || cd $DIR
}

PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
PATH=/home/dominik/.local/bin/:$PATH
PATH=/opt/stellarium/bin/:$PATH
PATH=/home/dominik/.config/coc/extensions/coc-clangd-data/install/11.0.0/clangd_11.0.0/bin:$PATH

export BROWSER=/usr/bin/chromium
export TERMINAL=/usr/bin/urxvt
export EDITOR=/usr/local/bin/vim

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
bind -x '"\343": __fzf_cd2__'
bind -x '"ã": __fzf_cd2__'
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
