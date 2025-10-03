{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for Wayland + X11 hybrid support
    modesetting.enable = true;

    # Disable NVIDIA's experimental power management (causes suspend issues)
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Proprietary NVIDIA driver (Ampere cards run best with this)
    open = false;

    # NVIDIA settings utility
    nvidiaSettings = true;

    # Stable driver package
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Kernel parameters
  boot.kernelParams = [
    # NVIDIA: keep VRAM across suspend (required for stable resume)
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"

    # NVIDIA DRM modesetting (required for Wayland, also safer for X11)
    "nvidia-drm.modeset=1"

    # Work around PCIe resume flakiness on some Z690/NVIDIA setups
    "nvidia.NVreg_EnablePCIeGen3=0"

    # (Optional) Disable split lock detection (sometimes causes false kernel crashes)
    "split_lock_detect=off"

    # (Optional) Force suspend to deep sleep (S3) instead of light sleep
    "mem_sleep_default=deep"
  ];

  # Extra NVIDIA driver options for stability
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_EnableMSI=1
  '';

  # Wayland support tweaks
  environment.sessionVariables = {
    # GBM is the preferred backend for modern Wayland compositors
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
  };
}
