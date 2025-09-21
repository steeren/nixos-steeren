# sub/playwright-system.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.playwrightSystem = {
    enable = lib.mkEnableOption "Enable Playwright system dependencies";
  };

  config = lib.mkIf config.playwrightSystem.enable {
    environment.systemPackages = with pkgs; [
      # Node.js & package managers
      nodejs_24
      yarn
      pnpm

      # Playwright itself
      playwright
      playwright-driver

      # Utilities
      git
      curl
      unzip

      # Browser dependencies
      # libXScrnSaver
      xorg.libXcomposite
      xorg.libXrandr
      xorg.libXi
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXfixes
      alsa-lib
      libpng
      glib
      gtk3
      nss
      fontconfig
      freetype
      harfbuzz
      atk
      at-spi2-atk
      cairo
      pango
      # gdkPixbuf
      dbus
      libdrm
      # libwayland
      xorg.libxshmfence
    ];

    # Playwright browser cache path
    environment.variables.PLAYWRIGHT_BROWSERS_PATH = "$HOME/.cache/ms-playwright";

    # Safe flags for running browsers in sandboxed environments
    environment.variables.PLAYWRIGHT_CHROMIUM_ARGS = "--no-sandbox";
    environment.variables.PLAYWRIGHT_FIREFOX_ARGS = "--no-sandbox";
    environment.variables.PLAYWRIGHT_WEBKIT_ARGS = "--no-sandbox";
  };
}
