{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.color = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
    ];
  };

  users.extraUsers.color.extraGroups = [ "audio" ];

  programs.bash.promptInit = ''
    PS1='\[\033[01;94m\][\u@\h\[\033[01;37m\] \W\[\033[01;94m\]]\$\[\033[00m\] '
  '';

  environment.shellAliases = {
    icat = "kitty +kitten icat";
    ll = "ls -la";
    la = "ls -a";
    ssh = "kitten ssh";
    c = "sudo nixos-rebuild switch --flake './#laptop'";
    cu = "sudo nix flake update";
    cm = "git commit -am \"flake: update\"";
    ",," = "nix-shell -p ";
  };
}
