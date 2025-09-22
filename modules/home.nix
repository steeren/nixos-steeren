# sub/home.nix
{
  config,
  pkgs,
  specialArgs,
  lib,
  ...
}:

let
  myGitEmail = specialArgs.gitUseremail;
  myGitUsername = specialArgs.gitUsername;
in
{
  # Automatically back up conflicting files
  home-manager.backupFileExtension = "backup";

  home-manager.users.${specialArgs.username} =
    { ... }:
    {
      imports = [
        ./home/packages.nix
        ./home/fonts.nix
        # Pass myGit* as arguments to git.nix
        (import ./home/git.nix {
          inherit myGitEmail myGitUsername;
        })
        ./home/bash.nix
        ./home/direnv.nix
        ./home/laptop/monitors.nix

        ./home/apps/neovim
      ];

      # Required: make sure state version is set once
      home.stateVersion = "23.05";

      # Enable home-manager itself
      programs.home-manager.enable = true;

    };
}
