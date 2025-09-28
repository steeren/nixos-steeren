{
  description = "A declarative NixOS system configuration using Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add NVF
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nix-flatpak,
      # nvf,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      stateVersion = "25.05";
      secrets = import ./secrets.nix;
    in
    {
      nixosConfigurations.lian-li = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {
          inherit inputs outputs;
          # These are NixOS system-wide specialArgs, available to all NixOS modules
          hostname = "lian-li";
          system = system;
          stateVersion = stateVersion;

          # Secrets
          username = secrets.username;
          passwordHash = secrets.passwordHash;
          gitUseremail = secrets.gitUseremail;
          gitUsername = secrets.gitUsername;
        };

        modules = [
          # System state version
          {
            system.stateVersion = stateVersion; # Did you read the comment?
          }

          nix-flatpak.nixosModules.nix-flatpak

          ./modules/hosts/lian-li

          # nixos-hardware.nixosModules.lenovo-thinkpad-p1
          # Import the Home Manager NixOS module first
          home-manager.nixosModules.home-manager
          ./modules/home.nix

          (
            { ... }:
            {
              shell.enable = true;
              shell.aliases = {
                nix-re-bld = "sudo nix flake update && sudo nixos-rebuild switch --flake .";
              };

              docker.enable = true;

              # playwrightSystem.enable = true;

              gc.enable = true;
              gc.keepSystemGenerations = 5;
              gc.keepDays = 7;
              gc.pruneUserProfiles = true;
            }
          )
        ];
      };
    };
}
