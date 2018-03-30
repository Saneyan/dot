{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; {
    all = with pkgs; buildEnv {
      name = "all";

      paths = [
        git
        rustc
        cargo
        sbt
        scala
        yarn
      ];
    };
  };
}
