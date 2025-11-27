{
  inputs,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      spacing = 0;
      reload_style_on_change = true;

      modules-left = [
	"systemd-failed-units"
	"hyprland/workspaces"
	"hyprland/window"
      ];

      modules-center = ["clock"];

      modules-right = [
	"wireplumber"
	"tray"
      ];

      clock = {
	format = " {:%A %H:%M}";

	tooltip-format = "<tt><small>{calendar}</small></tt>";
	calendar = {
	  mode = "month";
	  weeks-pos = "left";
	  mode-mon-col = 3;
	};
      };


            "hyprland/workspaces" = {
              show-special = true;
              special-visible-only = true;
              format = "{icon}";

              format-icons = {
                "discord" = "";
                "todoist" = "";
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
    };
  };
}
