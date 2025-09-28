# modules/system.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../common
    ./hardware-p1.nix
    ../../system/services/displaylink.nix
    ./laptop.nix
  ];
}
