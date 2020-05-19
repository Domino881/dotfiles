# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -A --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

####    USER    ####

git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
setxkbmap -option caps:escape
export EDITOR=/usr/bin/vim

COLOR1='\e[38;5;223m'
COLOR2='\e[38;5;102m'
ENDCOLOR='\e[00m'
export PROMPT_DIRTRIM=2
if [ "$color_prompt" = yes ]; then
		PS1="\[$COLOR1\]\u\[$ENDCOLOR\]:\[$COLOR2\]\w\[$ENDCOLOR\]\$"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

alias compandrun='cd ~/Documents && PS1=\>'
alias latex='latex -output-format=pdf'
alias cpmf='cp ~/makefile .'

PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias bashrc='vim ~/.bashrc'

#fzf
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	  [[ -n "$files"  ]] && ${EDITOR:-vim} "${files[@]}"
}
bind -x '"\C-p": fe'
export FZF_DEFAULT_COMMAND='find .'
export FZF_DEFAULT_OPTS='
--color=16
--height 30%
--layout reverse
--inline-info
'
#make ranger change the shell directory
alias ranger='ranger --choosedir=$HOME/rangerdir;cd "$(cat $HOME/rangerdir)"'

BROWSER=/usr/bin/chromium
export BROWSER
TERMINAL=/usr/bin/urxvt
export TERMINAL
setxkbmap -option caps:escape
if [ -n "$DISPLAY" ]; then
	xset b off
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
