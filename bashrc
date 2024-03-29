# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
#-------------------
# alias
#-------------------
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'
alias background='xv -root -quit -max -rmode 5'
alias du='du -kh'
alias df='df -kTh'

alias ls='ls --color=auto'
alias la='ls -Al'
alias ll='ls -l'
alias ls='ls -hF --color'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lr='ls -lR'
alias lt='ls -ltr'
alias lm='ls -al |more'
alias tree='tree -Csu'

alias mo='make otapackage -j16'
alias mb='make bootimage -j16'
alias gc='git checkout'
alias gm='git commit'
alias gs='git status'
alias gn='git clean -fd'
alias gl='git log'

alias g='grep -nrE --color'
alias gh='grep -nrE --color --include="*.h"'
alias gc='grep -nrE --color --include="*.c"'
alias f='find . -name '

#---------------------------
# file and string related function:
#---------------------------
# find file by name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }
# use pattern $1 and Execute $2 to find file:
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# find str in files and highlight
function fstr()
{
  OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
      do
  case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
          done
          shift $(( $OPTIND - 1 ))
          if [ "$#" -lt 1 ]; then
            echo "$usage"
              return;
        fi
          local SMSO=$(tput smso)
          local RMSO=$(tput rmso)
          find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
          sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

#----------------------
# process/system relate function:
#----------------------
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

LC_TIME=en_US.UTF-8
# PS1='\[\e[1;35m\][\[\e[1;33m\]\u@\h \[\e[1;31m\]\w\[\e[1;35m\]]\[\e[1;36m\]\$ \[\e[0m\]'
PS1='\[\e[1;36m\]- \W \[\e[0m\]'

export PATH=~/bin:~/local/bin:~/local/stgit:/opt/riscv-none-gcc/7.2.0-4-20180606-1631/bin/:$PATH

# enable bash completion in interactive shells
if ! shopt -oq posix; then
 if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi 
