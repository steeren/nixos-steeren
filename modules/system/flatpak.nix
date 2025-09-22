{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak support";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of Flatpak app IDs to install declaratively.";
    };
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;

    # Portals for theme integration & file pickers
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    # Add Flathub as a remote declaratively
    services.flatpak.remotes = {
      flathub = {
        url = "https://flathub.org/repo/flathub.flatpakrepo";
      };
    };

    # Declarative flatpak installation (via activation script)
    system.activationScripts.installFlatpaks.text = lib.concatStringsSep "\n" (
      map (pkg: "flatpak install -y --noninteractive flathub ${pkg}") config.flatpak.packages
    );
  };
}
