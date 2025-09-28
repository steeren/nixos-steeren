# system-settings.nix
#
# Configures basic system-wide settings such as time,
# internationalization (i18n), and console behavior.
{
  config,
  pkgs,
  specialArgs,
  ...
}:
{

  services.xserver.videoDrivers = [
    "displaylink"
    "modesetting"
  ];

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];

}
