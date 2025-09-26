{
  inputs,
  pkgs,
  ...
}: {
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    settings = {
      input = {
        kb_layout = "at";

        # focus change on cursor move
        follow_mouse = 1;
        accel_profile = "flat";
        tablet.output = "current";
      };

      "$mod" = "ALT";
      bind =
        [
          "SUPER, F, exec, firefox"
          "SUPER, T, exec, alacritty"
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
    };
  };
}
