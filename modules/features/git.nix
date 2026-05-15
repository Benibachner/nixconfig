{ ... }:
{
  flake.homeModules.git =
    { pkgs, lib, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = "benedikt";
          user.email = "benedikt.theuretzbachner@gmail.com";
          alias = {
            s = "status --short";
            l = "log --oneline --graph";
            ps = "push";
            pl = "pull";
            br = "branch";
            co = "checkout";
            sw = "switch";
          };
        };
      };
    };
}
