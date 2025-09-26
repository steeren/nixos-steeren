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
    flatpak.packages = [ "io.mrarm.mcpelauncher" ];
  };
}
