# modules/system.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./system/hardware.nix
    ./system/boot.nix
    ./system/gnome-desktop.nix
    ./system/packages.nix
    ./system/settings.nix
    ./system/users.nix
    ./system/shell.nix

    # services
    ./system/services/docker.nix
    ./system/services/displaylink.nix
    ./system/services/gc.nix

    # apps/tools
    ./system/apps/playwright.nix
    # ./system/flatpak.nix
    # ./system/apps/minecraft.nix
  ];
}
