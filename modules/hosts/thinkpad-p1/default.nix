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
    ./hardware-thinkpad-p1.nix
    ./laptop.nix
  ];
}
