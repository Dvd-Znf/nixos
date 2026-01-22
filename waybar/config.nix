{
  mainBar = {
    layer = "top";
    height = 30;
    spacing = 0;
    modules-left = [
      "hyprland/workspaces"
      "hyprland/submap"
      "hyprland/window"
    ];
    # "modules-center": ["hyprland/window"],
    modules-right = [
      "pulseaudio"
      "cava"
      "network"
      "cpu"
      "memory"
      "temperature"
      "battery"
      "clock"
      "tray"
    ];
    # Modules configuration
    "hyprland/workspaces" = {
      disable-scroll = true;
      active-only = false;
      all-outputs = true;
      # persistent_workspaces = {
      # 1 = [ ];
      # 2 = [ ];
      # 3 = [ ];
      # 4 = [ ];
      # 5 = [ ];
      # 6 = [ ];
      # 7 = [ ];
      # 8 = [ ];
      # 9 = [ ];
      # };
      warp-on-scroll = false;
      show-special = true;
    };
    "hyprland/submap" = {
      format = "<span style=\"italic\">{}</span>";
    };
    tray = {
      spacing = 10;
    };
    clock = {
      format = "{:%b-%d | %H:%M:%S}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      interval = 1;
    };
    cpu = {
      format = "{usage}% ";
      tooltip = false;
    };
    memory = {
      format = "{}% ";
    };
    temperature = {
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = [
        ""
        ""
        ""
      ];
    };
    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% 󰂄";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      format-icons = [
        "󱃍"
        "󰁼"
        "󰁾"
        "󰂀"
        "󰁹"
      ];
    };
    network = {
      format-wifi = "{essid} ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };
    pulseaudio = {
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = "󰖁 {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
      on-click = "pavucontrol";
    };
    cava = {
      cava_config = "/home/david/.config/cava/config";
      framerate = 90;
      bars = 14;
      method = "pulse";
      source = "auto";
      stereo = true;
      reverse = false;
      bar_delimiter = 0;
      input_delay = 2;
      format-icons = [
        "▁"
        "▂"
        "▃"
        "▄"
        "▅"
        "▆"
        "▇"
        "█"
      ];
      actions = {
        on-click-right = "mode";
      };
    };
  };
}
