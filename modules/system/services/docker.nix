# modules/docker.nix
{ config, pkgs, specialArgs, lib, ... }:

{
  options.docker = {
    enable = lib.mkEnableOption "Enable Docker service and tools";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];

    # Optional: allow members of 'docker' group to run without sudo
    users.groups.docker = {
      members = [ specialArgs.username ];
    };
  };
}
