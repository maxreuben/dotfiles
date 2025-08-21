# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##### ── Oh My Zsh bootstrap ──────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# (Optional) Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Make Homebrew-provided completions available BEFORE compinit (OMZ runs it)
if command -v brew >/dev/null 2>&1; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
# If you keep completion files in $ZSH_CUSTOM/completions, expose them too:
fpath+=("${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/completions")

# Core plugins — adjust to taste
plugins=(
  git
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Load Oh My Zsh (runs compinit & loads plugins)
source "$ZSH/oh-my-zsh.sh"
unalias gk
##### ─────────────────────────────────────────────────────────────────────────

# iTerm2 shell integration (safe anywhere)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

##### ── Environment ──────────────────────────────────────────────────────────
export GPG_TTY=$(tty)
export MICRO_TRUECOLOR=1
export EDITOR="micro"

# PATH
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/bin:${PATH}"
# export PATH="/usr/local/bin:${PATH}"
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
export PATH="$PATH:/Users/reuben/.local/bin"

alias imgcat="/opt/homebrew/bin/imgcat"

##### ── Aliases ──────────────────────────────────────────────────────────────
# useful
alias fh="sudo find . -name"
alias ff="sudo find / -name"
alias hg="history | rg"
alias hf="history | fzf"
alias diff="delta"
alias vf='vim $(fzf)'
alias man="batman"
alias bg="batgrep"
alias top="htop"

alias sbb='sudo zsh -c "$(history -p !!)"'
alias root="sudo -i"
alias o="open"
alias zip="zip -r"
alias bc='bc -l'
alias h='history'
alias j='jobs -l'
alias mkdir='mkdir -pv'

# quick cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'
alias ~="cd ~"

# ls-esque
alias ll='eza -lah'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

# network
alias ping='ping -c 5'
alias fastping='ping -c 100 -s 2'
alias ports='netstat -tulanp'
alias wget='wget -c'
alias myip='curl ipaddress.sh'
alias myiplocation='curl ipinfo.io/$(myip)'

# desktop alert for long commands
alias alert='terminal-notifier -title "Terminal Alert" -subtitle "$([ $? = 0 ] && echo Success || echo Error)" -message "$(history | tail -n1 | sed -e '\''s/^[ ]*[0-9]*[ ]*//;s/[;&|] *alert$//'\'')"'

##### ── Conda (kept intact) ──────────────────────────────────────────────────
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/reuben/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/reuben/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/reuben/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/reuben/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

##### ── Your custom completions (functions first, then compdef) ──────────────


# Extra widgets for pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
# Only run when attached to a real TTY and interactive shell
if [[ -o interactive && -t 0 && -t 1 ]]; then
  stty -ixon 2>/dev/null
fi
bindkey '^s' pet-select

##### ── Small helpers ────────────────────────────────────────────────────────
function mkcd() {
    mkdir -p $1
    cd $1
}

function tinyurl() {
	curl "http://tinyurl.com/api-create.php?url=$1"
	echo ''	
}

function gitcd() {
	git clone $1
	DIR=$(ls -td -- */ | head -n 1 | cut -d'/' -f1) #get newest directory#
	cd $DIR
}

##### ── zoxide ───────────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"
# zsh function to auto-select the top match
function zz() {
  local target
  target=$(zoxide query "$@" | head -n1)
  if [[ -n "$target" ]]; then
    cd "$target"
  else
    echo "zz: no match for '$*'" >&2
    return 1
  fi
}


