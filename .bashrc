# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Import colorscheme from 'wal' asynchronously# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi


# pass options to free #
alias free="free -mt"
alias mount='mount |column -t'
alias meminfo="free -m -l -t" ## get top process eating memory

alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psf="ps auxf | fzf"
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10" ## get top 10 process eating cpu ##
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10" ## Get server cpu info ##
alias cpuinfo="lscpu" ## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ## ## get GPU ram on desktop / laptop##
#alias gpumeminfo="grep -i --color memory /var/log/Xorg.0.log"
#icons-interminal#
source /home/reuben/Downloads/Programs/icons-in-terminal/build/icons_bash.sh

# Launch AmongUs 
alias amongus="legendary launch 963137e4c29d4c79a81323b8fab03a40"

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'
alias ~="cd ~"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='exa -lah'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

#Set vim as default
export VISUAL=vimx
export EDITOR=vimx

alias vi=vimx
alias svi='sudo -e'
alias code='codium'
alias edit='gedit'

#useful aliases
alias fh="sudo find . -name"
alias ff="sudo find / -name"
alias hg="history | rg"
alias hf="history | fzf"
alias diff=delta
alias vf='vi $(sk)'
alias man=batman
alias bg=batgrep
alias top="htop"
alias zz=zi

alias sk="sk -m"
alias sbb='sudo "$BASH" -c "$(history -p !!)"'
alias root="sudo -i"
alias xo="xdg-open"
alias zip="zip -r"
alias bc='bc -l'
alias h='history'
alias j='jobs -l'
alias mkdir='mkdir -pv'

# Stop after sending count 5 packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
# list all TCP/UDP port
alias ports='netstat -tulanp'
alias wget='wget -c'
alias myip='curl ipaddress.sh'
alias myiplocation='curl ipinfo.io/$(myip)'

#yank to clipboard
alias yclip="yank -- xsel -b"
alias yclipl="yank -l -- xsel -b" #yank line to clipboard
#copy to clipboard (use with |)
alias clipit="xclip -sel clip"
#show clipboard#
alias clipshow="xclip -o -sel clip"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#make and change directory bash fn
mkcd () {
    mkdir -p $1
    cd $1
}


#add previous command to pet list
prev() {
    PREV=$(history -p !!)
    pet new $PREV
}

tinyurl () {
	curl http://tinyurl.com/api-create.php?url=$1
	echo ''	
}

gitcd () {
	git clone $1
	DIR=$(ls -td -- */ | head -n 1 | cut -d'/' -f1) #get newest directory#
	cd $DIR
}

function extract { #this function does not handle spaces in filename#
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

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

unset rc

source ~/.profile
source ~/.bash_completion/alacritty
source ~/.bash_completion/github-cli

alias alacritty-config="vim $HOME/.config/alacritty/alacritty.yml"
complete -C "dev_bestia_cargo_completion" cargo 

eval "$(starship init bash)" #initialize starship shell prompt
eval "$(zoxide init bash)" #initialize zoxide(z) autojump
