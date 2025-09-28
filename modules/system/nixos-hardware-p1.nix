# modules/system.nix
{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}:

{
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
    }:
    {
      # replace <your-hostname> with your actual hostname
      nixosConfigurations.${specialArgs.hostname} = nixpkgs.lib.nixosSystem {
        # ...
        modules = [
          # ...
          # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p1
        ];
      };
    };
}
