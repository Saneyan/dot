#!/bin/bash

cat <<EOL

                       ___ ___     
             ____     /  / \  \  
            / ___\   /  /   \  \  
           / /_/  > (  (     )  ) 
           \___  /   \  \   /  /  
          /_____/     \__\ /__/  

           gfunction Dot Setup


EOL

# Tasks
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
  for f in $(filter_by_env ${dots[@]}); do
    [ ! -e $HOME/$f ] && ln -sv $dot_dir/$(remove_prefix_dot $f) $HOME/$f
  done

  mkdir -pv $conf_dir

  # From inside of the dot directory to private config directory
  for f in $(filter_by_env ${confs[@]}); do
    [ ! -e $conf_dir/$f ] && ln -sv $dot_dir/$(remove_prefix_dot $f) $conf_dir/$f
  done
}

# Utils
function run_tasks() {
  local -i current_task=0
  local -a use_tasks=($(filter_by_env $@))

  for t in ${use_tasks[@]}; do
    echo -n "($(((++current_task)))/${#use_tasks[@]}) "
    eval "${t}_task"
  done
}

function filter_by_env() {
  local remaining cond regex

  for t in $@; do
    if ! [[ $t =~ ":" ]]; then
      remaining="$remaining $t"
    else
      # Try to extract second substring from a string with ':' delimiter.
      # e.g. "abc:def" => "def"
      cond=${t#*:}

      # Compose a regular expression containing the positive lookahead construct.
      # e.g. "def" => (?=.*d)(?=.*e)(?=.*f)
      for i in $(seq 1 ${#cond}); do
        regex="${regex}(?=.*${cond:i-1:1})"
      done

      if echo $env | grep -Pq $regex; then
        remaining="$remaining ${t%:*}";
      fi
    fi
    regex=
  done

  echo $remaining
}

function command_exists() {
  local cmd="$(type -p $1)" && ! [ -z $cmd ]
}

function remove_prefix_dot() {
  echo $1 | sed -e "s/^\.//"
}

# System info. It can inherits ENV value.
declare env=$ENV

# X Window System has been installed? (yes => +x)
$(command_exists startx) && env="${env}x"

# Wayland has been installed? (yes => +w)
$(command_exists wayland-scanner) && env="${env}w"

# Either of X Window System or Wayland have been installed? (yes => +d)
[[ $env =~ [xw]+ ]] && env="${env}d"

# Current operating system is Linux? (yes => +l)
[[ $(uname) == "Linux" ]] && env="${env}l"

#/////////////////////////#
#                         #
#   Customize from here   #
#                         #
#/////////////////////////#
#
# You can append signs of condition after file or task name with delimiter ':'.
# The signs affect whether a symbolic link should be created or a task should run depending on current environment.
#
# case 'l' => The platform must be Linux.
# case 'x' => The windowing system must be X Window System.
# case 'w' => The windowing system must be Wayland.
# case 'd' => Desktop environment must be available.

# Files put on the home dir
declare -a dots=("bin"
                 ".bashrc"
                 ".emacs.d"
                 ".gitconfig"
                 ".gitignore"
                 ".tmux.conf"
                 ".vim"
                 ".vimrc"
                 ".gvimrc"
                 ".zsh.d"
                 ".zshenv"
                 ".xmonad:lx"
                 ".xorg.d:lx")

# Files put on the private config dir
declare -a confs=("nvim" "alacritty" "polybar:ld" "way-cooler:lw")

# Start to run tasks
run_tasks zplug dein link
