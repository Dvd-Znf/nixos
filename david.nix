{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.david = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [
      tree
      nixfmt
      cava
      gnome-text-editor
      wofi-emoji
      engrampa
      unzip
      nixpkgs-review
      devenv
      tor-browser
      heroic
      jetbrains.idea
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
    cc = "sudo nixos-rebuild switch --flake './#laptop'";
  };

  programs.hyprland.enable = false;
}
