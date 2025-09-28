{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.power-profiles-daemon.enable = false;

  # Example: NVIDIA setup for desktop
  services.xserver.videoDrivers = [ "nvidia" ];

  # co-pilot suggestions below:
  # hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.optimus_prime.enable = true;
  # hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
  # hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
}
