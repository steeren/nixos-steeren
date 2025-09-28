# gnome-desktop.nix
{
  config,
  pkgs,
  specialArgs,
  ...
}:

let
  gnomeExts = with pkgs.gnomeExtensions; [
    dash-to-dock
  ];
in
{
  services.xserver = {
    # Enable the Xorg server
    enable = true;

    displayManager.gdm = {

      enable = true;
      wayland = true; # Enable Wayland support in GDM
    };

    #To enable fractional scaling (ref: https://discourse.nixos.org/t/how-to-set-fractional-scaling-via-nix-configuration-for-gnome-wayland/56774/5)
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
  };

  # Configure OpenGL drivers
  hardware.graphics.enable = true;

  # Enable XWayland
  programs.xwayland.enable = true;

  environment.systemPackages =
    with pkgs;
    [
      # displaylink
      gnome-tweaks
      dconf-editor
      gnome-extension-manager
    ]
    ++ gnomeExts;
}
