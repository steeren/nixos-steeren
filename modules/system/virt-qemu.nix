{ config, pkgs, ... }:

{

  # Add user to libvirtd group
  users.groups.libvirtd.members = [ "stee" ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    # adwaita-icon-theme
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # Enable TPM 2.0 support
        swtpm.enable = true;

        # Enable UEFI support
        ovmf.enable = true;

        # Use the full OVMF firmware (with network boot support)
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    # Enable USB redirection in virt-manager
    spiceUSBRedirection.enable = true;
  };

  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  programs.virt-manager.enable = true;
}
