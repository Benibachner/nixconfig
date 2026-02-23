{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "backlight"
          "wireplumber"
          "power-profiles-daemon"
          "battery"
          "tray"
        ];

        "custom/actions" = {
          format = "";
          tooltip-format = "System Actions";
          on-click = "vicinae toggle";
        };

        "hyprland/workspaces" = {
          show-special = true;
          special-visible-only = true;
          format = "{icon}";

          format-icons = {
            "discord" = "";
            "todo" = "";
            "monitor" = "󰍹";
            "obsidian" = "";
            "spotify" = "";

            "default" = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };

          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          max-length = 50;
          format = "{title}";
          icon = false;
        };

        systemd-failed-units =
          let
            fish = lib.getExe pkgs.fish;
            bat = lib.getExe pkgs.bat;
          in
          {
            format = "✗ {nr_failed}";
            on-click = "xdg-terminal-exec ${fish} -c \"${bat} --paging always -f (systemctl list-units --user --failed | psub -s -user-units) (systemctl list-units --failed | psub -s -system-units)\"";
            hide-on-ok = true;
          };

        clock = {
          format = " {:%A %H:%M}";

          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            weeks-pos = "left";
            mode-mon-col = 3;
          };

          actions = {
            on-click-right = "mode";
            on-click-middle = "shift_reset";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];
          tooltip-format = "{percent}%";
        };

        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "󰝟";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          tooltip-format = "{volume}% on {node_name}";
          on-click = lib.getExe pkgs.pwvucontrol;
          on-click-right = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "group/power" = {
          orientation = "inherit";

          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
          };

          modules = [
            "battery"
            "idle_inhibitor"
            "power-profiles-daemon"
          ];
        };

        battery = {
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.2f}W↓ {capacity}%\n{timeTo}";
          tooltip-format-charging = "{power:>1.2f}W↑ {capacity}%\n{timeTo}";
          tooltip-format-plugged = "{capacity}%";

          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        idle_inhibitor = {
          format = "{icon}";

          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        disk = {
          format = "󰋊 {percentage_free}%";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        temperature = {
          format = " {temperatureC}°C";
          interval = 5;
          critical-format = "󰸁 {temperatureC}°C";
          critical-threshold = 90;
        };

        memory = {
          format = " {used}/{total}GiB";
          interval = 5;
        };

        tray = {
          spacing = 5;
        };
      };
    };
  };
}
