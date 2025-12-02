{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    settings = {
      input = {
        kb_layout = "at";

	touchpad = {
	  natural_scroll = true;
	};

        # focus change on cursor move
        follow_mouse = 1;
        accel_profile = "flat";
        tablet.output = "current";
      };

      monitor = [
	",preferred,auto,1.25"
      ];

      exec-once = [
        # finalize startup
        # set cursor for HL itself
        # "hyprctl setcursor Bibata-Modern-Classic 24"
	"waybar"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;

        #allow_tearing = true;
        resize_on_border = true;
      };

      decoration = {
        rounding = 10;
        rounding_power = 3;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 7;

          popups = true;
          popups_ignorealpha = 0.2;
        };
      };

      xwayland.force_zero_scaling = true;

      "$mod" = "ALT";
      bind =
        [
          "SUPER, F, exec, firefox"
	  "SUPER, ENTER, exec, firefox"
          "SUPER, T, exec, alacritty"
          "SUPER, E, exec, nautilus"
          "$mod, M, exec, pkill Hyprland"
          "$mod, F, togglefloating,"
	  "$mod, R, exec, fuzzel"
	  "$mod, Q, killactive"
	  # "$mod, mouse:273, resizewindow"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
	"$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];
    };
  };
}
