{
  description = "A declarative NixOS system configuration using Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add NVF
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      ...
    }:
    let
      hostname = "p2-nixos";
      system = "x86_64-linux";
      stateVersion = "25.05";
      secrets = import ./.secrets.nix;
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {
          # These are NixOS system-wide specialArgs, available to all NixOS modules
          hostname = hostname;
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
          # Import the Home Manager NixOS module first
          home-manager.nixosModules.home-manager

          ./modules/system.nix
          ./modules/home.nix
          ./modules/profiles/laptop.nix
          # ./modules/profiles/desktop.nix

          nvf.nixosModules.default # <— THIS wires NVF in
          (
            { ... }:
            {
              shell.enable = true;
              shell.aliases = {
                nix-re-bld = "sudo nix flake update && sudo nixos-rebuild switch --flake .";
              };

              # neovim.enable = true;

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
