{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.tlp.enable = false; # Disable TLP
  services.power-profiles-daemon.enable = true; # Enable systemd-native power management

  # Optional: tune CPU scaling governor and suspend behavior
  # services.power-profiles-daemon.default-profile = "balanced"; # options: "balanced", "performance", "power-saver" <-- doesn't seem to work

  # Laptop-specific kernel tweaks
  # boot.kernelParams = [ "pcie_aspm=force" ]; #<- this is the nuclear option to force enable ASPM.

}
