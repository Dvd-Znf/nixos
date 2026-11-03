{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
  modules = [
    "title"
    "separator"
    "os"
    "host"
    "kernel"
    "uptime"
    "packages"
    "shell"
    "display"
    "de"
    "wm"
    "wmtheme"
    "theme"
    "icons"
    "font"
    "cursor"
    "terminal"
    "terminalfont"
    {
      type = "cpu";
      temp = true;
    }
    "gpu"
    "memory"
    # "swap"
    "disk"
    "localip"
    "battery"
    "poweradapter"
    "locale"
    "break"
    "colors"
  ];
  logo = {
    source = builtins.fetchurl {
      url = "https://d.furaffinity.net/art/honeymoss/1750718989/1750718989.honeymoss_cozymoon.png";
      sha256 = "sha256-Pj5zCEGAD2Cn9prZ6YvDcEJdR9w4dVR3YoxOgFBGc0s=";
    };
    width = 40;
  };
  display = {
    color = {
      keys = "light_blue"; # Key color
      title = "light_blue"; # Title color
    };
    key = {
      type = "both"; # string, icon, both, or none
    };
    percent = {
      type = 3; # 1=number, 2=bar, 3=both, 9=colored number
      color = {
        green = "green";
        yellow = "light_yellow";
        red = "light_red";
      };
    };
  };
}
