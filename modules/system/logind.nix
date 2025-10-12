{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.logind = {
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    # idleAction = "ignore";
    extraConfig = ''
      IdleAction=ignore
    '';
  };
}
