# Dot

My dotfiles.

## Setup

See `setup.sh` to know setup tasks and which files are linked to depending on system environment.

```
$ git clone https://github.com/Saneyan/dot.git
$ cd dot; ./setup.sh
```

## Nix Packages

Instead of ansible some packages are installed through Nixpkg to manage system packages independently.

```
$ nix-env -i all
```
