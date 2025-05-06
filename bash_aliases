#! /bin/bash
#
alias cl="clear"
alias cp="cp -iv"
alias df="df -h"
alias du="du -h"
alias greppy="grep -nrI --include=\*.py"
alias grepmd="grep -nrI --include=\*.md"
alias grepjs="grep -nrI --include=\*.js"
alias e="eza -l"
alias er="eza -lr"
alias ed="eza -ld */"
alias h="history"
alias j="jobs -l"
#
alias l='ls -l'
alias ll='ls -la'
alias lr="ls -ltr"
alias ld="ls -ld */"
alias ldr="ls -ldr */"
#
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias rm="rm -iv"
alias rp="realpath -s"
#
alias tmux="tmux -2"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tn="tmux new -s"
alias tkill="tmux kill-session -t"
#
alias vim="vim -p"
alias wl="wc -l"
alias wh="which"

# github
alias gs="gh copilot suggest"
alias ge="gh copilot explain"

# nix & home-manager
nixplugins () {
nix-env -f '<nixpkgs>' -qaP -A ${1}Plugins
}
alias hmb="home-manager build"
alias hms="home-manager switch"

# my aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias diff="diff --color -y"
alias cpv='rsync -ah --info=progress2' # copy with progress bar

## functions
# sidediff
sidediff () {
diff --color -y <(fold -s -w ${3:-20} $1) <(fold -s -w ${3:-20} $2)
}
# wn
nv () {
watch -n ${1:-1} nvidia-smi
}
# ps aux
psa () {
ps aux | grep $1
}
# docker
dockersudo () {
sudo usermod -aG docker $USER && newgrp docker
}
