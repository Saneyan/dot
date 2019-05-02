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

# General tasks
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

# Dev server tasks
function code-server_task() {
  echo "Installing code-server..."
  local version="1.939-vsc1.33.1"
  curl -L https://github.com/cdr/code-server/releases/download/$version/code-server$version-linux-x64.tar.gz > /tmp/code-server-bin.tar.gz
  mkdir -pv /tmp/code-server-bin
  tar zxvf /tmp/code-server-bin.tar.gz -C /tmp/code-server-bin --strip-components=1
  mkdir -pv ~/.local/bin
  mv /tmp/code-server-bin/code-server ~/.local/bin
  mkdir -pv ~/.config/code-server/extensions
  mkdir -pv ~/.config/code-server/user-data
}

# Go tasks
function go-lang_task() {
  echo "Installing golang..."
  local version="1.12.4"
  curl -L https://dl.google.com/go/go$version.linux-amd64.tar.gz > /tmp/go.tar.gz
  mkdir -pv /tmp/go
  tar zxvf /tmp/go.tar.gz -C /tmp/go --strip-components=1
  mv -v /tmp/go ~/go
}

function go-migrate_task() {
  echo "Installing migrate..."
  local version="v4.3.1"
  curl -L https://github.com/golang-migrate/migrate/releases/download/$version/migrate.linux-amd64.tar.gz > /tmp/migrate.tar.gz
  mkdir -pv /tmp/migrate
  tar zxvf /tmp/migrate.tar.gz -C /tmp/migrate --strip-components=1
  mv -v /tmp/migrate/migrate.linux-amd64 ~/.local/bin/migrate
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
#
# Files put on the home dir
# declare -a dots=()
#
# Files put on the private config dir
# declare -a confs=()
#

if [[ $1 == "server" ]]; then
  declare -a dots=()

  declare -a confs=()

  run_tasks code-server
elif [[ $1 == "go" ]]; then
  declare -a dots=()

  declare -a confs=()

  run_tasks go-lang go-migrate
else
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

  declare -a confs=("nvim" "alacritty" "polybar:ld" "way-cooler:lw")

  run_tasks zplug dein link
fi

