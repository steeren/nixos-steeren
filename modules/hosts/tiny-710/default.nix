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
    ./hardware-lian-li.nix
  ];
}
