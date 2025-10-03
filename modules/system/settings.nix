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
  ## Declared now in Commons/default.nix
  # nixpkgs.config.allowUnfree = true;
  # nix.settings = {
  #   experimental-features = [
  #     "nix-command"
  #     "flakes"
  #   ];
  #   download-buffer-size = 524288000;
  #   http-connections = 100;
  #   max-jobs = "auto";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  # console.keyMap = "de";

  # Set the system's hostname using the value passed from flake.nix
  networking.hostName = specialArgs.hostname; # Use the passed hostname argument
  networking.networkmanager.enable = true;

  # Enable the NTP client to maintain system time.
  services.ntp.enable = true;

  # Enable Intel microcode updates (for Intel CPUs).
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;

  # Enable firmware updates via the fwupd service.
  services.fwupd.enable = true;
  # Enable periodic TRIM for SSDs.
  services.fstrim.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.zsh.enable = true;

  networking.firewall.enable = false;

  services.gvfs.enable = true;

}
