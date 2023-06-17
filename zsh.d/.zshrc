#!/usr/bin/env zsh
#
# .zshrc
#
# @rev    G-0.2.2
# @update 2014-08-18
# @author Saneyuki Tadokoro <saneyan@saneyan.gfunction.com>

#
# General settings
#

source ~/.zplug/init.zsh

# WSL2 only
export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export "LIBGL_ALWAYS_INDIRECT=1"
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/opt/homebrew/opt/mysql-client/bin:$PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
export GOPATH=$HOME/go
export JAVA_HOME=/usr/lib/jvm/default
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/saneyan/Development/github.com/athearth/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/saneyan/Development/github.com/athearth/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/saneyan/Development/github.com/athearth/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/saneyan/Development/github.com/athearth/google-cloud-sdk/completion.zsh.inc'; fi

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-syntax-highlighting"

zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf, \
  use:"*darwin*amd64*"

zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq

zplug "b4b4r07/emoji-cli", \
  on:"stedolan/jq"

# Load theme file
zplug 'dracula/zsh', as:theme

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Bind key
bindkey -v 

# Do not beep
setopt no_beep

# Move directory without typing "cd"
setopt auto_cd

# Stack history
setopt auto_pushd

# Correct spelling
setopt correct

# Supplement like --val=value
setopt magic_equal_subst

# Use prompt subset
setopt prompt_subst

# Type correct command
setopt correct

# Notify as soon as possible when background jobs get change
setopt notify

# Process "which command" as =command
setopt equals

# Use auto complete
autoload -U compinit; compinit

# Show lists if there are some choices
setopt auto_list

# Change specific choice by typing [Tab]
setopt auto_menu

# Pack lists
setopt list_packed

# Show file types
setopt list_types

# Enable reverse menu complete
bindkey "^[[Z" reverse-menu-complete


# Enable glob function
setopt extended_glob

zstyle ':completion:*:default' menu select

#
# History setting
#

# History file
HISTFILE=~/.zsh_history

# Saving history size
HISTSAVING=10000

# Saving history size (on memory)
HISTSIZE=10000

# General commands
alias b="exit"
alias s="sudo"
alias pg="ps aux | grep"
alias pn="ping -c 3 8.8.8.8"

# Git
alias -g g="git"

# Vim
alias -g e="which nvim &>/dev/null && nvim || vim"

# kill
alias -g k="kill"
alias -g k9="kill -9"

# ls
alias -g l="ls -lh --color=auto"
alias -g la="ls -lhA --color=auto"

# cp
alias -g cp="cp -fv"
alias -g cpr="cp -rfv"

# mv
alias -g mv="mv -v"

# System
alias reb="sudo reboot"
alias shu="sudo shutdown -Ph now"

# Viewers with a pipe (upper case letter)
alias -g L="| less"
alias -g T="| tail"
alias -g H="| head"
alias -g G="| grep"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
