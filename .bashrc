#!/bin/bash

# Make sure this is running in a terminal
if [[ -z $TERM ]] ; then
  return 0 # Not a terminal - BAILOUT
fi

# Source scripts, if available
scripts=(
  /etc/bashrc
)
for script in ${scripts[@]} ; do
  echo "Sourcing ${script}..."
  if [[ -f ${script} ]] ; then
    source "${script}"
  else
    echo "WARNING: ${script} not found"
  fi
done

# Vi better for Ry
set -o vi

# Prevent Ctrl-S from freezing terminal
stty -ixon

# Environment Variables
export EDITOR='vim'
export HISTIGNORE='*clear-line:oc login*:history | grep*:*CREDS=*:cs:cls:clear:fg*'
export LC_COLLATE="C" # Sort ls with dotfiles first
export LS_COLORS=${LS_COLORS}:'di=0;34:ex=0;32:fi=0;37:ow=0;34:'
export VISUAL='vim'

# Dynamically build PATH
paths=(
  /opt/homebrew/bin
  /opt/homebrew/opt/coreutils/libexec/gnubin
  /opt/homebrew/opt/findutils/libexec/gnubin
  /opt/homebrew/opt/gawk/libexec/gnubin
  /opt/homebrew/opt/gnu-getopt/libexec/gnubin
  /opt/homebrew/opt/gnu-indent/libexec/gnubin
  /opt/homebrew/opt/gnu-sed/libexec/gnubin
  /opt/homebrew/opt/gnu-tar/libexec/gnubin
  /opt/homebrew/opt/gnutls/libexec/gnubin
  /opt/homebrew/opt/grep/libexec/gnubin
  $PATH
)
new_path=""
for path in ${paths[@]} ; do
  new_path="${new_path}${path}:"
done
export PATH="${new_path%:*}" # Remove trailing colon

# Colors (W/ escapes for PS1)
PS1_RED="\[\e[0;31m\]"
PS1_GREEN="\[\e[0;32m\]"
PS1_YELLOW="\[\e[0;33m\]"
PS1_BLUE="\[\e[0;34m\]"
PS1_BOLD="\[\e[01m\]"
PS1_COLOROFF="\[\e[0;m\]"

# Colors (No escapes)
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
BOLD="\e[01m"
COLOROFF="\e[0;m"

# Aliases
alias ..='cd ..'
alias beefup='wakeonlan -i 10.0.2.6 "7c:10:c9:41:00:58"'
alias cls='cs'
alias chmox="chmod +x"
alias chownme="sudo chown ${USER}:${USER}"
alias create-virtualenv='python3 -m venv .venv'
alias ct="date '+%Y%m%d%H%M%S'"
alias dir='ll'
alias g='git'
alias ll='ls -lahH --color --group-directories-first'
alias remove-exec='find . -type f -exec chmod -x {} \;'
alias venv='source ./.venv/bin/activate'

# Better cat
cat() {
  [[ $# -eq 1 ]] && /bin/cat "$1"
  [[ $# -gt 1 ]] && for i in $@ ; do printf "\n==> ${i} <==\n" ; /bin/cat "$i" ; printf "\n" ; done
}

# Clear screen and show contents after cd
cd() {
  builtin cd "${1}"
  pwd > "${HOME}/.config/.lastdir"
  /usr/bin/clear
  ls -lah --color --group-directories-first
}

# Kill and remove all docker containers
docker-clean() {
  docker kill $(docker ps -q) 2> /dev/null
  docker rm $(docker ps -a -q) 2> /dev/null
}

# Debug container as root
docker-debug() {
  docker run -it --rm -u 0:0 ${1} /bin/bash
}

# Download a file
download() {
  [[ $# -ne 1 ]] && echo "download <URL>" && return 1
  curl -L "${1}" -o "${1##*/}"
}

# Fuzzy change directory under $HOME
fcd() {
  local dir=$(find ${HOME} -path '*/\.*' -prune \
                           -o -name 'node_modules' -prune \
                           -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
  /usr/bin/clear
  ls -lah --color --group-directories-first
}

# Fuzzy find file
ff() {
  find ${HOME} -path '*/\.*' -prune \
               -o -type f -print 2> /dev/null | fzf +
}

# Flush DNS on MacOS
flush-dns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

# Convert iPhone photos to a common format
heic-to-jpg() {
  local file=''
  for file in "$@" ; do
    printf "Converting ${file} to JPG..."
    convert "${file}" "${file%%.*}.jpg"
    echo 'Done!'
  done
}

# "Throw" away files to ~/.trash
trash() { mv $@ ${HOME}/.trash ; }

# Get git branch name and style it depending on clean/dirty status
_git_status() {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
  if [[ $branch != "" ]] ; then # If in git directory
    if [[ $(git status) != *'nothing to commit'* ]] ; then # Dirty directory
      local gitstat="${PS1_YELLOW}(${branch}*)${PS1_COLOROFF} "
    else # Clean directory
      local gitstat="${PS1_GREEN}(${branch})${PS1_COLOROFF} "
    fi
  fi
  printf "${gitstat}"
}

# Set PS1 with PROMPT_COMMAND
# Based off this: https://gist.github.com/henrik/31631
_prompt_command() {
  [[ -n ${VIRTUAL_ENV} ]] && local pyenv="(${VIRTUAL_ENV##*/}) "
  local gitstat="$(_git_status)"
  [[ $(tput cols) -lt 90 ]] && local newline="\n"
  local end="${PS1_BOLD} $ ${PS1_COLOROFF}"
  PS1="${pyenv}${gitstat}${PS1_BOLD}\u@\h:${PS1_BLUE}\W${PS1_COLOROFF}${newline}${end}"
}
PROMPT_COMMAND="_prompt_command"

# 'cd' into last opened directory
if [[ -f "${HOME}/.config/.lastdir" ]] ; then
  builtin cd $(cat "${HOME}/.config/.lastdir")
fi

# Clear system messages
/usr/bin/clear

# Print welcome message
printf "${BLUE}Welcome!${COLOROFF}\n"
