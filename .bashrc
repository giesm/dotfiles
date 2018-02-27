# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# include sensible.bash
if [ -f ~/.bin/sensible.bash ]; then
   source ~/.bin/sensible.bash
fi

export VISUAL=nvim

source /etc/bash_completion.d/git-prompt

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

DULL=0;         BRIGHT=1
FG_BLACK=30; FG_RED=31; FG_GREEN=32; FG_YELLOW=33; FG_BLUE=34; FG_VIOLET=35; FG_CYAN=36; FG_WHITE=37; FG_NULL=00
BG_BLACK=40; BG_RED=41; BG_GREEN=42; BG_YELLOW=43; BG_BLUE=44; BG_VIOLET=45; BG_CYAN=46; BG_WHITE=47; BG_NULL=00
# ANSI Escape Commands
ESC="\033"; NORMAL="\[$ESC[m\]"; RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"
# DULL TEXT
BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
RED="\[$ESC[${DULL};${FG_RED}m\]"
GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"
# BRIGHT TEXT
BBLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
BRED="\[$ESC[${BRIGHT};${FG_RED}m\]"
BGREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
BYELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
BBLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
BVIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
BCYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
BWHITE="\[$ESC[${BRIGHT};${FG_WHITE}m\]"

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXITCODE="$?"

    local HOSTCOLOR=$VIOLET
    local USERCOLOR=$YELLOW
    local PATHCOLOR=$BLUE
    local GITCOLOR=$GREEN

    local GITSTATUS="$(__git_ps1)"

    PS1=" ${HOSTCOLOR} \h  ${USERCOLOR} \u  ${PATHCOLOR} \w  ";

    if [[ ! -z $GITSTATUS ]]; then
        PS1+="${GITCOLOR}${GITSTATUS}  ";
    else
        PS1+="";
    fi

    if [ $EXITCODE == 0 ]; then
        PS1+="\n $GREEN\$ $RESET❱ ";
    else
        PS1+="\n $RED\$ $RESET❱ ";
    fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bin/z.sh ]; then
    . ~/.bin/z.sh
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

eval `keychain --eval --quiet id_rsa`

