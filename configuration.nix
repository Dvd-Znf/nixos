{
  config,
  lib,
  pkgs,
  ...
}:

{

  imports = [ ./david.nix ];

  nix = {
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    extraOptions = ''
      extra-substituters = https://kwanix.cachix.org
      extra-trusted-public-keys = kwanix.cachix.org-1:HhHwGXxynHmP16OJtsXjB1yTq6EuPoIjUlnXPB6cuNQ=
    '';
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "blahaj";
      themePackages = with pkgs; [ plymouth-blahaj-theme ];
    };

    loader = {
      timeout = 10;
      efi = {
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = [ "nodev" ];
        useOSProber = false;
      };

    };
  };

  fileSystems."/home/david/homevol" = {
    device = "/dev/SillyVolGroup/homevol";
    fsType = "ext4";
  };

  networking.hostName = "Asus-Tuf";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    reverseSync.enable = false;
    offload = {
      enableOffloadCmd = false;
      enable = false;
    };
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.openssh.enable = true;
  services.pipewire.enable = false;
  services.libinput.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;
  services.displayManager.ly.enable = true;
  services.displayManager.ly.settings = {
    animation = "colormix";
    asterisk = "0x2022";
    bigclock = "en";
    box_title = null;
    brightness_down_key = null;
    brightness_up_key = null;
    clear_password = false;
    clock = null;
    colormix_col1 = "0x00808080";
    colormix_col2 = "0x20000000";
    colormix_col3 = "0x00FFFFFF";
    initial_info_text = "balls";
  };

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;
  programs.waybar.enable = true;
  programs.steam.enable = true;
  programs.kdeconnect.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    killall
    btop
    swww
    wl-clip-persist
    wl-clipboard
    grim
    slurp
    networkmanagerapplet
    kdePackages.partitionmanager
    kdePackages.filelight
    bibata-cursors
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    git
    adwaita-icon-theme
    viewnior
    mpv
    pavucontrol
    hyprpolkitagent
    prismlauncher
    gh
    komac
    libqalculate
    cliphist
    gimp
    libnotify
    nvtopPackages.nvidia
    nvtopPackages.intel
  ];

  fonts.packages =
    with pkgs;
    [
      comic-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
