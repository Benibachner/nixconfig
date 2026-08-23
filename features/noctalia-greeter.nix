{ inputs, ... }:
{
  flake.nixosModules.noctalia-greeter =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia-greeter = {
        enable = true;
        # Optional: extra flags after `--` on noctalia-greeter-session
        greeter-args = "";
        # Full declarative greeter.toml (overwritten each activation). See examples/greeter.toml.
        settings = {
          cursor = {
            theme = "Bibata-Modern-Classic";
            size = 24;
            path = "${pkgs.bibata-cursors}/share/icons";
          };
        };
      };
    };
}
