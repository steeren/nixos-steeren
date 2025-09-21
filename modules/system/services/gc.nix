{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}:

{
  options.gc = {
    enable = lib.mkEnableOption "Enable automatic pruning of old system and user generations";

    keepSystemGenerations = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Number of system generations to keep in the bootloader";
    };

    keepDays = lib.mkOption {
      type = lib.types.int;
      default = 7;
      description = "Delete store paths older than this many days";
    };

    pruneUserProfiles = lib.mkEnableOption "Also prune user profile generations (Home Manager)";
  };

  config = lib.mkIf config.gc.enable {
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than ${toString config.gc.keepDays}d";
    };

    boot.loader.systemd-boot.configurationLimit = config.gc.keepSystemGenerations;

    # Optional user profile pruning via systemd user service + timer
    systemd.user.services.user-prune = lib.mkIf config.gc.pruneUserProfiles {
      description = "Prune old user profiles";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nix}/bin/nix profile wipe-history --older-than ${toString config.gc.keepDays}d --profile /home/${specialArgs.username}/.nix-profile";
      };
    };

    systemd.user.timers.user-prune = lib.mkIf config.gc.pruneUserProfiles {
      description = "Run user-prune daily";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
