{ ... }:
{
  flake.homeModules.fish =
    { pkgs, lib, ... }:
    {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting

          fish_vi_key_bindings
          set -g fish_key_bindings fish_vi_key_bindings
          set -U fish_cursor_insert block
          bind -M insert -m default vj cancel repaint-mode
          set -g fish_sequence_key_delay_ms 200

        '';
        shellAliases = {
          nv = "nvim";
          vi = "nvim";
          pwr = "powerprofilesctl";
        };
        shellAbbrs =
          let
            expand = cmd: {
              setCursor = "%";
              expansion = cmd;
            };
          in
          {
            gcm = expand ''git commit -m "%"'';
            nr = expand "nix run nixpkgs#%";
          };
      };
    };
}
