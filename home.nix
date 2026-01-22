{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland/hyprland.conf);
  };

  xdg.desktopEntries = {
    minecraftuwu = {
      name = "Minecraft :3 (1.21.10)";
      exec = "${pkgs.prismlauncher}/bin/prismlauncher --launch 1.21.10";
      icon = "/home/david/.local/share/PrismLauncher/instances/1.21.10/icon.png";
      terminal = false;
      categories = [
        "Game"
        "ActionGame"
        "AdventureGame"
        "Simulation"
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-pink-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        variant = "macchiato";
      };
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
  };

  # qt = {
  #   enable = true;
  #   style = {
  #     name = "catppuccin-mocha-mauve";
  #     package = pkgs.catppuccin-qt5ct;
  #   };
  # };

  services = {
    dunst = {
      enable = true;
      settings = lib.importTOML ./dunst/config.toml;
    };
  };

  programs = {
    bash = {
      enable = true;
      historySize = 1000;
      historyFileSize = 10000;
      historyControl = [
        "erasedups"
        "ignorespace"
      ];
      initExtra = builtins.readFile ./bash/.bashrc;
    };
    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };
    television = {
      enable = true;
      settings.default_channel = "nix-search-tv";
    };
    fastfetch = {
      enable = true;
      settings = import ./fastfetch/config.nix;
    };
    waybar = {
      enable = true;
      style = ./waybar/style.css;
      settings = import ./waybar/config.nix;
    };
    wofi = {
      enable = true;
      style = ./wofi/style.css;
      settings = import ./wofi/config.nix;
    };
    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./kitty/kitty.conf;
      themeFile = "Catppuccin-Macchiato";
      shellIntegration.enableBashIntegration = true;
    };
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = import ./swaylock/config.nix;
    };
    element-desktop = {
      enable = true;
      settings = lib.importJSON ./element-desktop/config.json;
    };
    vesktop = {
      enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    keepassxc = {
      enable = true;
    };
    cava = {
      enable = true;
      settings = lib.importTOML ./cava/config;
    };
    btop = {
      enable = true;
      settings = lib.importTOML ./btop/btop.conf;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
