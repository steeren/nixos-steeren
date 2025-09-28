{
  config,
  lib,
  pkgs,
  ...
}:
{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # From ChatGPT:
  # The "nvidia.NVreg_EnablePCIeGen3=0" kernel parameter is crucial — it prevents issues on
  # certain motherboards (especially with Z690) where Gen 3/Gen 4 PCIe instability can cause
  # "fallen off the bus" errors.
  # nvidia.NVreg_EnablePCIeGen3=0 → disables NVIDIA’s Gen3 fallback quirk.
  # pcie_aspm=off → disables Active State Power Management, which often helps with stability on
  boot.kernelParams = [
    "nvidia.NVreg_EnablePCIeGen3=0"
    "pcie_aspm=off"
  ];

  # PreserveVideoMemoryAllocations=1 → helps avoid crashes on resume/suspend.
  # EnableMSI=1 → uses Message Signaled Interrupts, usually more stable on modern chipsets.
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_EnableMSI=1
  '';

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

  };
}
