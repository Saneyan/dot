#!/bin/bash

#
# Tasks
#

function nix_task() {
  echo "Installing Nix..."
  bash <(curl https://nixos.org/nix/install)
  source ~/.nix-profile/etc/profile.d/nix.sh
}

function zplug_task() {
  echo "Installing zplug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

function dein_task() {
  echo "Installing dein.vim..."
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein.vim-installer.sh
  sh /tmp/dein.vim-installer.sh ~/.cache/dein
}

function link_task() {
  echo "Linking dotfiles..."
  local dot_dir=$(cd $(dirname $0) && pwd)
  local conf_dir=$HOME/.config

  # From inside of the dot directory to the home directory
  for f in $(filter_by_env $dots); do
    [ ! -e $HOME/$f ] && ln -sv $dot_dir/$f $HOME
  done

  mkdir -pv $conf_dir

  # From inside of the dot directory to private config directory
  for f in $(filter_by_env $confs); do
    [ ! -e $CONFDIR/$f ] && ln -sv $dot_dir/$f $conf_dir
  done
}

#
# Utils
#
function setup() {
  local current_task=1
  local use_tasks=$(filter_by_env $tasks)
  local total_tasks=${use_tasks[#]}

  for t in $use_tasks; do
    echo "(${current_task}/${total_tasks})"
    eval "${t}_task"
    ((current_task++))
  done
}

function filter_by_env() {
  local remaining

  for t in $@; do
    if ! [[ $t =~ ":" ]]; then remaining="$remaining $t"
    elif [[ ${t#*:} =~ ^[lxw]+$ ]]; then remaining="$remaining ${t%:*}"; fi
  done

  echo $remaining
}

# You can append a suffix tag composed by signs of condition after file or task name.
# This tag affects whether a symbolic link should be created or a task should run depending on current environment.
#
# case 'l' => The platform should be Linux.
# case 'x' => The windowing system should be X Window System or Wayland.
# case 'w' => The windowing system should be Wayland.

# Files put on the home dir
declare -a dots=(bashrc bin emacs.d gitconfig gitignore tmux.conf vim zsh.d nixpkgs xmonad:lx xorg.d:lx)

# Files put on the private config dir
declare -a confs=(alacritty polybar:lx way-cooler:lw)

# Setup tasks
declare -a tasks=(nix zplug dein link)

filter_by_env ${confs[@]}

cat <<EOL
If you want to install Nix packages execute \`nix-env -i {profile_name}\`.
These Nix profiles are available:
  - all
EOL

