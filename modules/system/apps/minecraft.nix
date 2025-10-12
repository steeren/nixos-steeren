{
  config,
  lib,
  ...
}:

# Minecraft Bedrock Launcher via Flatpak
# This currently doesn't work out of the box, the launcher needs to be tweaked to run on wayland.
# Steps:
# 1. Find the .destop launcher
#    > find ~/.local/share /var/lib/flatpak/exports/share /usr/share/applications -iname '*mcpelauncher*.desktop' 2>/dev/null
# 2. Copy it into
#    > cp /var/lib/flatpak/exports/share/applications/io.mrarm.mcpelauncher.desktop ~/.local/share/applications/
# 3. Edit the copy
#    > vi ~/.local/share/applications/io.mrarm.mcpelauncher.desktop
# 4. Add the following options to the Exec line:
#    --nosocket=wayland --nosocket=fallback-x11 --socket=x11
#    E.g. So it looks like this (future versions might have other args):
#    Exec=flatpak run --branch=stable --arch=x86_64  --nosocket=wayland --nosocket=fallback-x11 --socket=x11 --command=mcpelauncher-ui-qt --file-forwarding io.mrarm.mcpelauncher @@u %U @@
# Next steps would be to automate this to be part of the nixos config. All that said, automating this would be work, and who knows
# when they might fix the launcher to work on wayland out of the box. If you automate this monkey patch, then you'll be unaware its fixed.

{
  options.minecraft = {
    enable = lib.mkEnableOption "Enable Minecraft Bedrock Launcher via Flatpak";
  };

  config = lib.mkIf config.minecraft.enable {
    services.flatpak.enable = true;
    services.flatpak.packages = [ "io.mrarm.mcpelauncher" ];
  };
}
