{
  config,
  lib,
  ...
}:

{
  options.minecraft = {
    enable = lib.mkEnableOption "Enable Minecraft Bedrock Launcher via Flatpak";
  };

  config = lib.mkIf config.minecraft.enable {
    services.flatpak.enable = true;
    services.flatpak.packages = [ "io.mrarm.mcpelauncher" ];
  };
}
