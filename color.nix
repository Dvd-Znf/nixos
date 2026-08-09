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

}
