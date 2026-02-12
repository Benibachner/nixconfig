{
  self,
  inputs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./waybar/waybar.nix
    ./fuzzel.nix
    ./stylix.nix
  ];
}
