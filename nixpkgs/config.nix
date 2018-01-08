{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; {
    all = with pkgs; buildEnv {
      name = "all";

      paths = [
        git
        way-cooler
        ruby
        imagemagick
        neovim
        dirmngr
        zsh
        tmux
        rustc
        cargo
        sbt
        scala
        yarn
      ];
    };
  };
}
