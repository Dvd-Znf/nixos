{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      nixfmt
      cava
      mousepad
      wofi-emoji
      mate.engrampa
      unzip
      nixpkgs-review
      devenv
    ];
  };

  users.extraUsers.david.extraGroups = [ "audio" ];

  programs.bash.promptInit = ''
    PS1='\[\033[01;94m\][\u@\h\[\033[01;37m\] \W\[\033[01;94m\]]\$\[\033[00m\] '
  '';

  environment.shellAliases = {
    icat = "kitty +kitten icat";
    ll = "ls -la";
    la = "ls -a";
    ssh = "kitten ssh";
    c = "vim /etc/nixos/configuration.nix";
    cc = "sudo nixos-rebuild switch --flake '/etc/nixos/#laptop'";
    ccu = "sudo nixos-rebuild switch --upgrade";
  };

  programs.hyprland.enable = true;
  environment.sessionVariables = {
    HYPR_PLUGIN_DIR = pkgs.symlinkJoin {
      name = "hyprland-plugins";
      paths = with pkgs.hyprlandPlugins; [
        hyprexpo
      ];
    };
  };
}
