{ config, pkgs, ... }:

let
  my_vim_configurable = pkgs.vim_configurable.override {
      python3 = pkgs.python3;
  };
in
{
  # environment.systemPackages = with pkgs; [ vim_configurable ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.enableNixpkgsReleaseCheck = false;

  home.username = "iria";
  home.homeDirectory = "/home/iria";
  home.stateVersion = "24.05";

  # Enable Vim through Home Manager
  home.packages = with pkgs; [
    # my_vim_configurable
    vimHugeX
    bat
    # cargo
    direnv
    dust
    difftastic
    eza
    git
    gh
    go
    fish
    fzf
    git
    htop
    jq
    kitty
    lazygit
    ncdu
    neovim
    nil
    obs-studio
    pyright
    ripgrep
    ruff
    rustup
    shellcheck
    shfmt
    silver-searcher
    starship
    tmux
    tree
    # for python
    gcc
    gcc.cc.lib
    # installed by nix, not pip
    (python311.withPackages (ps: with ps; [
      numpy
      requests
      isort
      black
      flake8
    ]))
  ];
  # NB that the belo wwill want to overwrite the .bashrc and the .profile
  # programs.bash.enable = true;  # Needed for bash-specific setup
  # make sure source that in order to use ENV variables
  # $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib";
    DUMMY = "dummy";
  };
  imports = [
    ./starship.nix
  ];
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    # global in the machine under ~/.config/direnv/direnvrc
    stdlib = ''
      export LD_LIBRARY_PATH="$HOME/.nix-profile/lib''${LD_LIBRARY_PATH:+:''${LD_LIBRARY_PATH}}"
    '';
  };
}
